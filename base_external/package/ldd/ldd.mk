
##############################################################
#
# LDD
#
##############################################################

LDD_VERSION = 643047fe28da48ee377ec8acdffc4b36b88667a9
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = git@github.com:salvadorz/ldd3.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

#https://buildroot.org/downloads/manual/manual.html#_infrastructure_for_packages_building_kernel_modules
#MODULE_SUBDIRS may be set to one or more sub-directories (relative to the package source top-directory) 
# where the kernel module sources are.
LDD_MODULE_SUBDIRS = misc-modules scull 

# Add module load and unload your writer, finder and finder-test utilities/scripts to the installation steps below
define LDD_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/scull/scull_load   $(TARGET_DIR)/usr/sbin
	$(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/usr/sbin
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_load   $(TARGET_DIR)/usr/sbin
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/sbin
endef

$(eval $(kernel-module))
$(eval $(generic-package))
