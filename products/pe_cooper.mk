# Check for target product
ifeq (pe_cooper,$(TARGET_PRODUCT))

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pe/prebuilt/bootanimation/mdpi.zip:system/media/bootanimation.zip

# include PE common configuration
include vendor/pe/config/pe_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/cooper/cm.mk)

PRODUCT_NAME := pe_cooper

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pe/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pe/tools/addprojects.py $(PRODUCT_NAME))

endif
