include $(TOPDIR)/rules.mk

PKG_NAME:=samknows_base-files-router
PKG_VERSION:=2017
PKG_RELEASE:=4

include $(INCLUDE_DIR)/package.mk

define Package/samknows_base-files-router
  SECTION:=samknows
  CATEGORY:=SamKnows
  TITLE:=SamKnows base-files for routers
  URL:=https://www.ilpuntotecnicoeadsl.com
  DEPENDS:=+openssl +curl
endef

define Package/samknows_base-files-router/config
  select BUSYBOX_CONFIG_ASH_RANDOM_SUPPORT
  select BUSYBOX_CONFIG_ROUTE
  select BUSYBOX_CONFIG_IP if !PACKAGE_ip-full
endef

define Build/Compile
endef

define Package/samknows_base-files-router/install
    $(CP) ./files/* $(1)
endef

$(eval $(call BuildPackage,samknows_base-files-router))
