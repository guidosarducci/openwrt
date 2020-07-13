#
# Copyright (C) 2020 Tony Ambardar <itugrok@yahoo.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=bpftool
PKG_VERSION:=$(LINUX_VERSION)
PKG_RELEASE:=1

PKG_MAINTAINER:=Tony Ambardar <itugrok@yahoo.com>
PKG_LICENSE:=GPL-2.0 BSD-2-Clause

PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/bpftool/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=bpftool - eBPF subsystem utility
  VERSION:=$(LINUX_VERSION)-$(PKG_RELEASE)
  URL:=http://www.kernel.org
  DEPENDS:=@!IN_SDK @!LINUX_4_14 +libelf
endef

define Package/bpftool-minimal
  $(call Package/bpftool/Default)
  TITLE+= (Minimal)
  VARIANT:=minimal
  DEFAULT_VARIANT:=1
  PROVIDES:=bpftool
  ALTERNATIVES:=200:/usr/sbin/bpftool:/usr/libexec/bpftool-minimal
endef

define Package/bpftool-full
  $(call Package/bpftool/Default)
  TITLE+= (Full)
  VARIANT:=full
  PROVIDES:=bpftool
  ALTERNATIVES:=300:/usr/sbin/bpftool:/usr/libexec/bpftool-full
  DEPENDS+= +libbfd +libopcodes
endef

define Package/bpftool-minimal/description
  A tool for inspection and simple manipulation of eBPF programs and maps.
endef

define Package/bpftool-full/description
  A tool for inspection and simple manipulation of eBPF programs and maps.
  This full version uses libbfd and libopcodes to support disassembly of
  eBPF programs and jited code.
endef

TARGET_CFLAGS += -ffunction-sections -fdata-sections -flto
TARGET_LDFLAGS += -Wl,--gc-sections

MAKE_FLAGS += \
	EXTRA_CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
	OUTPUT="$(PKG_BUILD_DIR)/" \
	$(if $(findstring c,$(OPENWRT_VERBOSE)),V=1,V='')

ifeq ($(BUILD_VARIANT),minimal)
  HAVE_LIBBFD:=0
else
  HAVE_LIBBFD:=1
endif

# Perform a "throw-away" make to create FEATURE-DUMP.* files to edit later.
# The "//" in the make target is actually needed, very unPOSIXly.
define Build/Configure
	$(MAKE_FLAGS) $(MAKE) $(PKG_JOBS) -C $(LINUX_DIR)/tools/bpf/bpftool \
		$(PKG_BUILD_DIR)//libbpf/libbpf.a
	(cd $(PKG_BUILD_DIR); cat FEATURE-DUMP.bpftool libbpf/FEATURE-DUMP.libbpf \
		> FEATURE-DUMP.openwrt)
	$(SED) 's/feature-libbfd=[01]/feature-libbfd=$(HAVE_LIBBFD)/' \
		$(PKG_BUILD_DIR)/FEATURE-DUMP.openwrt
endef

define Build/Compile
	$(MAKE_FLAGS) FEATURES_DUMP="$(PKG_BUILD_DIR)/FEATURE-DUMP.openwrt" \
		$(MAKE) $(PKG_JOBS) -C $(LINUX_DIR)/tools/bpf/bpftool
endef

define Package/bpftool-$(BUILD_VARIANT)/install
	$(INSTALL_DIR) $(1)/usr/libexec
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bpftool $(1)/usr/libexec/bpftool-$(BUILD_VARIANT)
endef

$(eval $(call BuildPackage,bpftool-minimal))
$(eval $(call BuildPackage,bpftool-full))
