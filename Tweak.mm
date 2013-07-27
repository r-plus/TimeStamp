#import <EventKit/EventKit.h>
#import <libactivator/libactivator.h>

#define kAddTimeStampToCalendar "jp.r-plus.timestamp"

@interface TimeStamp : NSObject <LAListener>
@end

@implementation TimeStamp
+ (void)load
{
    @autoreleasepool {
        TimeStamp *listener = [[self alloc] init];
        [LASharedActivator registerListener:listener forName:@kAddTimeStampToCalendar];
    }
}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)receiveEvent forListenerName:(NSString *)listenerName
{
    if ([listenerName isEqualToString:@kAddTimeStampToCalendar]) {
        // NOTE: Springboard have authentication.
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"H:mm"];
        event.title = [format stringFromDate:[NSDate date]];
        event.timeZone = [NSTimeZone defaultTimeZone];
        event.startDate = [NSDate date];
        event.endDate = [event.startDate dateByAddingTimeInterval:1];
        event.allDay = YES;
        event.calendar = eventStore.defaultCalendarForNewEvents;
        NSError *error = NULL;
        [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&error];
        [eventStore release];
        // Prevent default behavior.
        receiveEvent.handled = YES;
    }
}
@end
