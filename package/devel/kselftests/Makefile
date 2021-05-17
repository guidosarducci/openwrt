#
# Copyright (C) 2011-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=kselftests
PKG_VERSION:=$(LINUX_VERSION)
PKG_RELEASE:=1

PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
PKG_MAINTAINER:=Tony Ambardar <itugrok@yahoo.com>
PKG_FLAGS:=nonshared

# Perf's makefile and headers are not relocatable and must be built from the
# Linux sources directory
#PKG_BUILD_DIR:=$(LINUX_DIR)/tools/kselftests-$(TARGET_DIR_NAME)

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/kselftests
  SECTION:=devel
  CATEGORY:=Development
#  DEPENDS:= +libelf +libdw +PACKAGE_libunwind:libunwind +libpthread +librt +objdump @!IN_SDK @!TARGET_arc770 @KERNEL_PERF_EVENTS
  DEPENDS:= +libbpf +libcap +libelf +zlib +libpthread +librt @!IN_SDK
  TITLE:=Linux Kernel Self-testing
  VERSION:=$(LINUX_VERSION)-$(PKG_RELEASE)
  URL:=http://www.kernel.org
endef

define Package/kselftests/description
  kselftests is the Linux kernel self-test suite
endef

HOST_CFLAGS += -I$(LINUX_DIR)/tools/include

TARGET_LDFLAGS += $(INTL_LDFLAGS)

#TARGET_CFLAGS += -ffunction-sections -fdata-sections -flto
#TARGET_LDFLAGS += -Wl,--gc-sections -Wl,--as-needed

#MAKE_FLAGS = \
#	ARCH="$(LINUX_KARCH)" \
#	NO_LIBPERL=1 \
#	NO_LIBPYTHON=1 \
#	NO_NEWT=1 \
#	NO_LZMA=1 \
#	NO_BACKTRACE=1 \
#	NO_LIBNUMA=1 \
#	NO_GTK2=1 \
#	NO_LIBAUDIT=1 \
#	NO_LIBCRYPTO=1 \
#	NO_LIBUNWIND=1 \
#	NO_LIBZSTD=1 \
#	NO_LIBCAP=1 \
#	CROSS_COMPILE="$(TARGET_CROSS)" \
#	CC="$(TARGET_CC)" \
#	LD="$(TARGET_CROSS)ld" \
#	EXTRA_CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
#	LDFLAGS="$(TARGET_LDFLAGS)" \
#	KBUILD_HOSTCFLAGS="$(HOST_CFLAGS)" \
#	$(if $(findstring c,$(OPENWRT_VERBOSE)),V=1,V='') \
#	WERROR=0 \
#	O=$(PKG_BUILD_DIR) \
#	prefix=/usr

TEST_TARGETS = bpf

MAKE_PATH:=tools/testing/selftests

#	CC="$(TARGET_CC)" \
#	LD="$(TARGET_CROSS)ld" \

MAKE_VARS = \
	ARCH="$(LINUX_KARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	EXTRA_CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	KBUILD_HOSTCFLAGS="$(HOST_CFLAGS)"

MAKE_FLAGS = \
	$(if $(findstring c,$(OPENWRT_VERBOSE)),V=1,V='') \
	WERROR=0 \
	O=$(PKG_BUILD_DIR) \
	TARGETS="$(TEST_TARGETS)" \
	prefix=/usr \
	--no-print-directory

MAKE_INSTALL_FLAGS += \
	INSTALL_PATH="$(PKG_INSTALL_DIR)/kselftests"
	

TARGET_CONFIGURE_OPTS:=
define Build/Configure
endef

define Build/Compile
	+$(MAKE_VARS) \
	$(MAKE) $(PKG_JOBS) -C $(LINUX_DIR)/$(MAKE_PATH) \
		$(MAKE_FLAGS) ;
endef

define Build/Install
	$(MAKE_VARS) \
	$(MAKE) -C $(LINUX_DIR)/$(MAKE_PATH) \
		$(MAKE_INSTALL_FLAGS) install ;
endef

define Package/kselftests/install
#	$(INSTALL_DIR) $(1)/usr/bin
#	$(INSTALL_BIN) $(PKG_BUILD_DIR)/perf $(1)/usr/bin/
endef

$(eval $(call BuildPackage,kselftests))
