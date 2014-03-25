# config.mk
#
# Product-specific compile-time definitions.
#

ifeq ($(TARGET_ARCH),)
TARGET_ARCH := arm
endif

BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true

-include $(QCPATH)/common/msm8610/BoardConfigVendor.mk

# [FEATURE]-ADD by ling.yi@jrdcom.com, 2013/11/08, Bug 550459, FOTA porting begin
# used to define TCT FOTA solution for scribe5
TARGET_USES_TCT_FOTA := true
# [FEATURE]-ADD by ling.yi@jrdcom.com, 2013/11/08, Bug 550459, FOTA porting end

#Add by changmei.chen@tcl.com, 2013/11/15, For root check machnism.
FEATURE_TCT_ROOTCHECK := true

#TODO: For bring-up only; disable QC display path
TARGET_BYPASS_QCUI := true

#TODO: Fix-me: Setting TARGET_HAVE_HDMI_OUT to false
# to get rid of compilation error.
TARGET_HAVE_HDMI_OUT := false
TARGET_USES_OVERLAY := true
TARGET_NO_BOOTLOADER := false
TARGET_NO_KERNEL := false
TARGET_NO_RADIOIMAGE := true
TARGET_NO_RPC := true

TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_CPU_ABI  := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := krait
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true

TARGET_HARDWARE_3D := false
TARGET_BOARD_PLATFORM := msm8610
TARGET_BOOTLOADER_BOARD_NAME := MSM8610
TARGET_ARCH_LOWMEM := true

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37
BOARD_KERNEL_CMDLINE += $(EXTRA_BOARD_KERNEL_CMDLINE)
BOARD_KERNEL_SEPARATED_DT := true

BOARD_EGL_CFG := device/qcom/$(TARGET_BOARD_PLATFORM)/egl.cfg

BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00A00000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00A00000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 377487360
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2214592512
BOARD_USBIMAGE_PARTITION_SIZE_KB := 4030440
BOARD_CACHEIMAGE_PARTITION_SIZE := 75497472
BOARD_PERSISTIMAGE_PARTITION_SIZE := 5242880
BOARD_TOMBSTONESIMAGE_PARTITION_SIZE := 73400320
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

# Enable suspend during charger mode
BOARD_CHARGER_ENABLE_SUSPEND := true

# Add NON-HLOS files for ota upgrade
ADD_RADIO_FILES ?= true
TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true
TARGET_USES_INTERACTION_BOOST := false

# Added to indicate that protobuf-c is supported in this build
PROTOBUF_SUPPORTED := true

TARGET_ADDITIONAL_BOOTCLASSPATH := qcom.fmradio:oem-services:qcmediaplayer

HAVE_FT_FW_UPGRADE := true

# Resource manager for audio-video usecases
BOARD_USES_RESOURCE_MANAGER:= true
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_msm
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
