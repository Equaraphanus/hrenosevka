IOSEVKA_SOURCE_GIT=https://github.com/be5invis/Iosevka
NERD_FONTS_PATCHER=https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/FontPatcher.zip

SOURCES_DIR=3rdparty
NERD_PATCHER_DIR=$(SOURCES_DIR)/nerd-patcher
IOSEVKA_DIR=$(SOURCES_DIR)/iosevka
HRENOSEVKA_DIR=$(IOSEVKA_DIR)/dist/hrenosevka/ttf

dist: $(NERD_PATCHER_DIR) $(HRENOSEVKA_DIR) patch-fonts.mk
	mkdir -p $@
	make -j -f patch-fonts.mk PATCHER_DIR=$(NERD_PATCHER_DIR) FONTS_DIR=$(HRENOSEVKA_DIR) OUTPUT_DIR=$@

$(IOSEVKA_DIR):
	mkdir -p $(SOURCES_DIR)
	git clone --depth=1 $(IOSEVKA_SOURCE_GIT) $@

$(IOSEVKA_DIR)/private-build-plans.toml: $(IOSEVKA_DIR) hrenosevka.toml
	cp hrenosevka.toml $(IOSEVKA_DIR)/private-build-plans.toml

$(HRENOSEVKA_DIR): $(IOSEVKA_DIR)/private-build-plans.toml make-hrenosevka.sh
	./make-hrenosevka.sh

$(SOURCES_DIR)/FontPatcher.zip:
	mkdir -p $(SOURCES_DIR)
	wget -O $@ $(NERD_FONTS_PATCHER)

$(NERD_PATCHER_DIR): $(SOURCES_DIR)/FontPatcher.zip
	unzip $(SOURCES_DIR)/FontPatcher.zip -d $@
