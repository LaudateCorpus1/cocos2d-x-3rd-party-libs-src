# OPENSSL
OPENSSL_VERSION := 0.9.8zc
OPENSSL_URL := https://www.openssl.org/source/openssl-$(OPENSSL_VERSION).tar.gz

#FIXME: we don't want to use scripts to determine which libraries should be
#       included, because there is bug in cross compile

# PKGS += openssl
# ifeq ($(call need_pkg,"openssl"),)
# PKGS_FOUND += openssl
# endif


$(TARBALLS)/openssl-$(OPENSSL_VERSION).tar.gz:
	$(call download,$(OPENSSL_URL))

.sum-openssl: openssl-$(OPENSSL_VERSION).tar.gz

openssl: openssl-$(OPENSSL_VERSION).tar.gz .sum-openssl
	$(UNPACK)
	$(MOVE)

.openssl: openssl
	cd $< && ./config no-shared --openssldir=$(PREFIX)
	cd $< && $(MAKE) $(HOSTVARS)
	cd $< && $(MAKE) install
	touch $@
