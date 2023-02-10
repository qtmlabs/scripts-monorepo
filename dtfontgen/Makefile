ifndef CDE_SOURCE_TREE
$(error CDE_SOURCE_TREE must be set to CDE source path)
endif

.PHONY: all clean

dir_guard = @mkdir -p $(@D)

all: dist/fonts.dir dist/fonts.alias

build/mk_fonts_alias: $(CDE_SOURCE_TREE)/programs/fontaliases/mk_fonts_alias.c
	$(dir_guard)
	gcc -o $@ $<

build/mixed.alias: build/mk_fonts_alias
	./$< 1 > $@

build/google.alias: build/mixed.alias
	python3 dtfontgen.py $< > $@

dtfonts.ttc:
	./build.sh

dist/fonts.alias: build/google.alias
	$(dir_guard)
	cp -T $< $@

dist/dtinfo.bdf: $(CDE_SOURCE_TREE)/programs/fontaliases/dtinfo.bdf
	$(dir_guard)
	cp -T $< $@

dist/dtfonts.ttc: dtfonts.ttc
	$(dir_guard)
	cp -T $< $@

dist/fonts.scale: dist/dtfonts.ttc
	mkfontscale dist

dist/fonts.dir: dist/fonts.scale dist/dtinfo.bdf
	mkfontdir dist

clean:
	rm -rf dist build
