TARGET_USES_QCOM_BSP := true

ifeq ($(TARGET_USES_QCOM_BSP), true)
# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
endif #TARGET_USES_QCOM_BSP

DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8610/overlay

ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
# media_profiles and media_codecs xmls for 8610
PRODUCT_COPY_FILES += device/qcom/msm8610/media/media_profiles_8610.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8610/media/media_codecs_8610.xml:system/etc/media_codecs.xml
endif #TARGET_ENABLE_QC_AV_ENHANCEMENTS

$(call inherit-product, device/qcom/common/common.mk)
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

PRODUCT_PROPERTY_OVERRIDES += \
       ro.moz.omx.hw.max_width=1280 \
       ro.moz.omx.hw.max_height=720 \

PRODUCT_NAME := msm8610
PRODUCT_DEVICE := msm8610

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8610/audio_policy.conf:system/etc/audio_policy.conf

# audio UCM files
PRODUCT_COPY_FILES += \
    device/qcom/msm8610/snd_soc_msm/snd_soc_msm_8x10_wcd:system/etc/snd_soc_msm/snd_soc_msm_8x10_wcd \
    device/qcom/msm8610/snd_soc_msm/snd_soc_msm_8x10_wcd_skuab:system/etc/snd_soc_msm/snd_soc_msm_8x10_wcd_skuab \
    device/qcom/msm8610/snd_soc_msm/snd_soc_msm_8x10_wcd_skuaa:system/etc/snd_soc_msm/snd_soc_msm_8x10_wcd_skuaa

# Bluetooth configuration files
PRODUCT_COPY_FILES += \
    system/bluetooth/data/main.conf:system/etc/bluetooth/main.conf \
    system/bluetooth/data/audio.conf:system/etc/bluetooth/audio.conf

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom
PRODUCT_COPY_FILES += \
    device/qcom/msm8610/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    device/qcom/msm8610/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msm8610/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += wcnss_service

#Added by czb@tcl.com 20140305,add recovery & modem version showed in *#3228#,start
PRODUCT_PACKAGES += mverproxy
#End: Added by czb@tcl.com 20140305,add recovery & modem version showed in *#3228#

PRODUCT_PACKAGES += trace_util
PRODUCT_PACKAGES += libtraceability

#ANT stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

PRODUCT_PACKAGES += \
            bnfc-nci \
            libnfc_nci_jni \
            nfc_nci_pn547.msm8610 \
            NfcNci \
            Tag \
            com.android.nfc_extras
PRODUCT_PROPERTY_OVERRIDES += \
    ro.moz.nfc.enabled=true


# Sensors feature definition file/s
PRODUCT_COPY_FILES += \
   frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml

# Enable strict operation
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.strict_op_enable=false

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.whitelist=/system/etc/whitelist_appops.xml

PRODUCT_COPY_FILES += \
    device/qcom/msm8610/whitelist_appops.xml:system/etc/whitelist_appops.xml

# Gecko low-memory killer setting overrides
#
# It would be nice to use PRODUCT_COPY_FILES here instead but that is not
# currently possible due to various |rm -rf ...| commands in
# {gaia,gonk-misc}/Android.mk that Make does not know about.
#
out/target/product/$(TARGET_PRODUCT)/system/gecko: gaia/profile/defaults/pref/lmk.js
.PHONY: gaia/profile/defaults/pref/lmk.js
gaia/profile/defaults/pref/lmk.js: gaia/profile.tar.gz
	echo 'pref("hal.processPriorityManager.gonk.BACKGROUND.KillUnderMB", 10);' > $@
	echo 'pref("hal.processPriorityManager.gonk.notifyLowMemUnderMB", 9);' >> $@

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := device/qcom/msm8610/nfc/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := device/qcom/msm8610/nfc/nfcee_access_debug.xml
endif


PRODUCT_COPY_FILES += \
        packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
        frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
        frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
        $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml \
        frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
        frameworks/native/data/etc/pn544nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf\
        frameworks/native/data/etc/pn544nfc/libnfc-nxp.conf:system/etc/libnfc-nxp.conf\
        frameworks/native/data/etc/pn544nfc/route.xml:system/etc/param/route.xml\
        frameworks/native/data/etc/pn544nfc/libpn547_fw.so:system/vendor/firmware/libpn547_fw.so

