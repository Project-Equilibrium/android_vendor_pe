# Check for target product
ifeq (pe_p880,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pe_xhdpi

# PE device overlay
#$(shell cp -f vendor/pe/prebuilt/common/bootanimation_framework/android-logo-mask_lg-xhdpi.png frameworks/base/core/res/assets/images/android-logo-mask.png)

#PRODUCT_COPY_FILES += \
#    vendor/pe/prebuilt/xhdpi/bootanimation.zip:system/media/bootanimation.zip

# include PE common configuration
include vendor/pe/config/pe_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/p880/cm.mk)

PRODUCT_NAME := pe_p880

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pe/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pe/tools/addprojects.py $(PRODUCT_NAME))

endif
