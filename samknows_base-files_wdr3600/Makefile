include $(TOPDIR)/rules.mk

PKG_NAME:=samknows_base-files_wdr3600
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/samknows_base-files_wdr3600
  SECTION:=samknows
  CATEGORY:=SamKnows
  TITLE:=SamKnows base-files
  DEPENDS:= +samknows_base-files-router
endef

define Build/Compile
endef

define Package/samknows_base-files_wdr3600/install
    $(CP) ./files/* $(1)
endef

$(eval $(call BuildPackage,samknows_base-files_wdr3600))
