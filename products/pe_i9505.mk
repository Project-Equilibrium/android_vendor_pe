 # Check for target product
ifeq (pe_i9505,$(TARGET_PRODU CT))

# include PE common configuration
include vendor/pe/config/pe_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/i9505/cm.mk)

# vendor hack
$(call vendor-replace,samsung,i9505)

PRODUCT_NAME := pe_i9505

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

