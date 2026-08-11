KEYMAP_DRAWER_VERSION := 0.23.0
KEYMAP_DRAWER := uvx --from keymap-drawer==$(KEYMAP_DRAWER_VERSION) keymap
KEYMAP_CONFIG := keymap-drawer/config.yaml
KEYMAP_SOURCE := config/dokodemo.keymap
KEYMAP_YAML := keymap-drawer/keymap.yaml
KEYMAP_SVG := keymap-drawer/keymap.svg

.PHONY: keymap keymap-svg

keymap:
	$(KEYMAP_DRAWER) -c $(KEYMAP_CONFIG) parse -z $(KEYMAP_SOURCE) -o $(KEYMAP_YAML)
	$(MAKE) keymap-svg

keymap-svg:
	$(KEYMAP_DRAWER) -c $(KEYMAP_CONFIG) draw \
		-j config/dokodemo.json -l dokodemo \
		-o $(KEYMAP_SVG) $(KEYMAP_YAML)
