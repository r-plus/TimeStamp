ARCHS = armv7
TARGET = iphone:clang::
include theos/makefiles/common.mk

TWEAK_NAME = TimeStamp
TimeStamp_OBJC_FILES = Tweak.mm
TimeStamp_FRAMEWORKS = EventKit
TimeStamp_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/tweak.mk
