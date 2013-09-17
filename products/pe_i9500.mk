# Check for target product
ifeq (pe_i9500,$(TARGET_PRODUCT))

# include PE common configuration
include vendor/pe/config/pe_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/i9500/cm.mk)

# vendor hack
$(call vendor-replace,samsung,i9500)

PRODUCT_NAME := pe_i9500

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pe/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pe/tools/addprojects.py $(PRODUCT_NAME))

endif
