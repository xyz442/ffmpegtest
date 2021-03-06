LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS) 

LOCAL_MODULE    :=x264
LOCAL_SRC_FILES :=./libx264/libx264.a
include $(PREBUILT_STATIC_LIBRARY)

LOCAL_MODULE    :=fdk_aac
LOCAL_SRC_FILES := ./fdk-aac/libfdk-aac.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := avutil
ifeq ($(TARGET_ARCH_ABI),armeabi)
     LOCAL_SRC_FILES := ./ffmpeg/armv5te/libavutil.a
else
     LOCAL_SRC_FILES := ./ffmpeg/armv7-a/libavutil.a
endif
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := avcodec
ifeq ($(TARGET_ARCH_ABI),armeabi)
    LOCAL_SRC_FILES := ./ffmpeg/armv5te/libavcodec.a
else
    LOCAL_SRC_FILES := ./ffmpeg/armv7-a/libavcodec.a
endif
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := avformat
ifeq ($(TARGET_ARCH_ABI),armeabi)
    LOCAL_SRC_FILES := ./ffmpeg/armv5te/libavformat.a
else
    LOCAL_SRC_FILES := ./ffmpeg/armv7-a/libavformat.a
endif
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_CFLAGS := -D__STDC_CONSTANT_MACROS -Wno-sign-compare -Wno-switch -Wno-pointer-sign -DHAVE_NEON=1 \
      -mfpu=neon -mfloat-abi=softfp -fPIC -DANDROID

LOCAL_C_INCLUDES := \
    ./$(LOCAL_PATH)/ffmpeg/include
    
LOCAL_SRC_FILES := \
    ffmpegexample.c

LOCAL_LDLIBS 	:= -llog -ljnigraphics -lz -ldl -lgcc
LOCAL_STATIC_LIBRARIES := avformat avcodec avutil x264 fdk_aac
LOCAL_MODULE := test
include $(BUILD_SHARED_LIBRARY)