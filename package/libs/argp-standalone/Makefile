#
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=argp-standalone
PKG_VERSION:=1.5.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/argp-standalone/argp-standalone
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_HASH:=4a93021dba421c04768dd2681dd5744c9843c1c2f097baab3872d965580c4706

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>
PKG_LICENSE:=LGPL-2.1-or-later

PKG_BUILD_FLAGS:=no-lto

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/meson.mk

define Package/argp-standalone
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Hierarchial argument parsing broken out from glibc
  URL:=http://www.lysator.liu.se/~nisse/misc/
endef

define Package/argp-standalone/description
  GNU libc hierarchial argument parsing library broken out from glibc.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP)   $(PKG_INSTALL_DIR)/usr/include/argp.h \
		$(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP)   $(PKG_INSTALL_DIR)/usr/lib/libargp.a \
		$(1)/usr/lib/
endef

define Host/Install
	$(INSTALL_DIR) $(1)/include
	$(CP)   $(HOST_BUILD_DIR)/argp.h \
		$(1)/include/
	$(INSTALL_DIR) $(1)/lib
	$(CP)   $(HOST_BUILD_DIR)/libargp.a \
		$(1)/lib/
endef

$(eval $(call BuildPackage,argp-standalone))
$(eval $(call HostBuild))
