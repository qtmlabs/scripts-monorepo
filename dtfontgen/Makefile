ifndef CDE_SOURCE_TREE
$(error CDE_SOURCE_TREE must be set to CDE source path)
endif

.PHONY: all clean

FONTS = \
	NotoSansCJK-VF.otf.ttc \
	NotoSansMonoCJK-VF.otf.ttc \
	NotoSerifCJK-VF.otf.ttc \
	Roboto-Italic[wdth,wght].ttf \
	RobotoMono-Italic[wght].ttf \
	RobotoMono[wght].ttf \
	RobotoSerif[GRAD,opsz,wdth,wght].ttf \
	RobotoSerif-Italic[GRAD,opsz,wdth,wght].ttf \
	RobotoSlab[wght].ttf \
	Roboto[wdth,wght].ttf

dir_guard = @mkdir -p $(@D)

all: dist/fonts.dir dist/fonts.alias $(DIST_FONTS)

build/mk_fonts_alias: $(CDE_SOURCE_TREE)/programs/fontaliases/mk_fonts_alias.c
	$(dir_guard)
	gcc -o $@ $<

build/mixed.alias: build/mk_fonts_alias
	./$< 1 > $@

build/google.alias: build/mixed.alias dtfontgen.py
	python3 dtfontgen.py $< > $@

$(patsubst %,downloads/%,$(FONTS)): build.sh urls.txt sha256sums.txt
	./build.sh

dist/fonts.alias: build/google.alias
	$(dir_guard)
	cp -T $< $@

dist/dtinfo.bdf: $(CDE_SOURCE_TREE)/programs/fontaliases/dtinfo.bdf
	$(dir_guard)
	cp -T $< $@

dist/%: downloads/%
	$(dir_guard)
	cp -T $< $@

dist/fonts.scale: $(patsubst %,dist/%,$(FONTS))
	mkfontscale dist

dist/fonts.dir: dist/fonts.scale dist/dtinfo.bdf
	mkfontdir dist

clean:
	rm -rf dist build
