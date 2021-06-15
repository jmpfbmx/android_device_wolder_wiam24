# Platform
TARGET_BRM_PLATFORM := mt6580
TARGET_BOARD_PLATFORM := mt6580

# Use the 6580 common part
include device/mediatek/mt6580/BoardConfig.mk

# Config partition size
-include $(MTK_PTGEN_OUT)/partition_size.mk
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

# Use the project config
include device/wolder/$(MTK_TARGET_PROJECT)/ProjectConfig.mk

# GO-ify
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
MALLOC_SVELTE := true

MTK_INTERNAL_CDEFS := $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),$(foreach v,$(shell echo $($(t)) | tr '[a-z]' '[A-Z]'),-D$(v))))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)=\"$(strip $($(t)))\"))

# Flags
MTK_GLOBAL_CFLAGS += $(MTK_INTERNAL_CDEFS)

# Boot cmd-line
BOARD_KERNEL_CMDLINE = bootopt=64S3,32N2,64N2

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/wolder/wiam24/bluetooth

# GAPPS Build
BUILD_WITH_GAPPS := false
