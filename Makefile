KEYMAP_DRAWER := keymap
KEYMAP_CONFIG := keymap-drawer/config.yaml
KEYMAP_FORMATTER := keymap-drawer/format.py
KEYMAP_SOURCE := config/dokodemo.keymap
KEYMAP_YAML := keymap-drawer/keymap.yaml
KEYMAP_SVG := keymap-drawer/keymap.svg
KEYMAP_LAYERS := Base CAD Nav Math Symbols Fn Hyper

.PHONY: keymap keymap-svg

keymap:
	$(KEYMAP_DRAWER) -c $(KEYMAP_CONFIG) parse -z $(KEYMAP_SOURCE) \
		-l $(KEYMAP_LAYERS) -o $(KEYMAP_YAML)
	python3 $(KEYMAP_FORMATTER) $(KEYMAP_YAML)
	$(MAKE) keymap-svg

keymap-svg:
	$(KEYMAP_DRAWER) -c $(KEYMAP_CONFIG) draw \
		-j config/dokodemo.json -l dokodemo \
		-o $(KEYMAP_SVG) $(KEYMAP_YAML)
