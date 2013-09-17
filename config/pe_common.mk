# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pe/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/pe/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/pe/prebuilt/common/bin/50-backupScript.sh:system/addon.d/50-backupScript.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/pe/prebuilt/common/etc/init.d/00check:system/etc/init.d/00check \
    vendor/pe/prebuilt/common/etc/init.d/01zipalign:system/etc/init.d/01zipalign \
    vendor/pe/prebuilt/common/etc/init.d/02sysctl:system/etc/init.d/02sysctl \
    vendor/pe/prebuilt/common/etc/init.d/03firstboot:system/etc/init.d/03firstboot \
    vendor/pe/prebuilt/common/etc/init.d/05freemem:system/etc/init.d/05freemem \
    vendor/pe/prebuilt/common/etc/init.d/06removecache:system/etc/init.d/06removecache \
    vendor/pe/prebuilt/common/etc/init.d/07fixperms:system/etc/init.d/07fixperms \
    vendor/pe/prebuilt/common/etc/init.d/09cron:system/etc/init.d/09cron \
    vendor/pe/prebuilt/common/etc/init.d/10sdboost:system/etc/init.d/10sdboost \
    vendor/pe/prebuilt/common/etc/init.d/98tweaks:system/etc/init.d/98tweaks \
    vendor/pe/prebuilt/common/etc/helpers.sh:system/etc/helpers.sh \
    vendor/pe/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf \
    vendor/pe/prebuilt/common/etc/init.d.cfg:system/etc/init.d.cfg

# Added xbin files
PRODUCT_COPY_FILES += \
    vendor/pe/prebuilt/common/xbin/zip:system/xbin/zip \
    vendor/pe/prebuilt/common/xbin/zipalign:system/xbin/zipalign
    
BOARD := $(subst pe_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# PE version
PE_VERSION_MAJOR = 1
PE_VERSION_MINOR = 0
PE_VERSION_MAINTENANCE = Alpha
PE_VERSION := $(PE_VERSION_MAJOR).$(PE_VERSION_MINOR).$(PE_VERSION_MAINTENANCE)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.pe.version=$(PE_VERSION) \
    ro.equilibrium.version=pe_$(BOARD)_$(PE_VERSION)_$(shell date +%Y%m%d-%H%M%S)

# Disable ADB authentication and set root access to Apps and ADB
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0

