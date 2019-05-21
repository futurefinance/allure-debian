#
# Makefile to build debian package

ALLURE_VERSION=2.3.5
ALLURE_URL="https://dl.bintray.com/qameta/generic/io/qameta/allure/allure/$(ALLURE_VERSION)/allure-$(ALLURE_VERSION).zip"

test:

clean:
	@dh_clean
	@-rm -rf ./target
	@-rm debian/stamp-makefile-build 2>/dev/null || true
	@-rm debian/stamp-makefile-install 2>/dev/null || true

build:
	@-rm -rf ./target
	@mkdir -p ./target
	@curl --silent --show-error --location --fail --retry 3 --output ./target/allure.zip "$(ALLURE_URL)"
	@unzip ./target/allure.zip -d "./target"
	@rm ./target/allure.zip

check:
	@/bin/true

INSTALL=install -m 755
INSTALL_FILE=install -m 644
INSTALL_KEY=install -m 600
COPY_DIR=cp -rfL
MOVE_DIR=mv -n

install:
	$(INSTALL) -d $(DESTDIR)/usr/share/allure
	$(COPY_DIR) target/allure-$(ALLURE_VERSION)/* $(DESTDIR)/usr/share/allure/
