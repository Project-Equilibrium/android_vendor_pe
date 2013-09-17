 # Check for target product
ifeq (pe_jfltexx,$(TARGET_PRODUCT)) 

# include PE common configuration
include vendor/pe/config/pe_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/jfltexx/cm.mk)

# vendor hack
$(call vendor-replace,samsung,jfltexx)

PRODUCT_NAME := pe_jfltexx 

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

