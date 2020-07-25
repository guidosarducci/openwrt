#
# Copyright (C) 2020 Tony Ambardar <itugrok@yahoo.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=libbpf
PKG_VERSION:=$(LINUX_VERSION)
PKG_RELEASE:=1

PKG_MAINTAINER:=Tony Ambardar <itugrok@yahoo.com>
PKG_LICENSE:=GPL-2.0 BSD-2-Clause

PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1
#PKG_FLAGS:=nonshared
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libbpf
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=libbpf - eBPF helper library
  VERSION:=$(LINUX_VERSION)-$(PKG_RELEASE)
  URL:=http://www.kernel.org
  DEPENDS:=@!IN_SDK @!LINUX_4_14 +libelf
endef

define Package/libbpf/description
  libbpf is a library for loading eBPF programs and reading and manipulating eBPF objects from user-space.
endef

MAKE_PATH:=tools/lib/bpf

MAKE_VARS += \
	CC="$(TARGET_CROSS)gcc" \
	CXX=hide_cxx_compiler \
	EXTRA_CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS) $(FPIC)" \
	OUTPUT="$(PKG_BUILD_DIR)/" \
	prefix="/usr" \
	$(if $(findstring c,$(OPENWRT_VERBOSE)),V=1,V='')
MAKE_FLAGS += \
	CXX=hide_cxx_compiler

Build/Configure:=

define Build/Compile
	$(MAKE_VARS) $(MAKE) $(PKG_JOBS) -C $(LINUX_DIR)/$(MAKE_PATH) $(MAKE_FLAGS)
endef

define Build/Install/Default
	$(MAKE_VARS) \
	$(MAKE) -C $(LINUX_DIR)/$(MAKE_PATH) \
		$(MAKE_INSTALL_FLAGS) \
		$(if $(1), $(1), install);
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/bpf
	$(CP) $(PKG_INSTALL_DIR)/usr/include/bpf/*.h $(1)/usr/include/bpf/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib$(LIB_SUFFIX)/libbpf.{a*,so*} \
		$(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib$(LIB_SUFFIX)/pkgconfig/libbpf.pc \
		$(1)/usr/lib/pkgconfig/
endef

define Package/libbpf/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib$(LIB_SUFFIX)/libbpf.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libbpf))
