ifndef CDE_SOURCE_TREE
$(error CDE_SOURCE_TREE must be set to CDE source path)
endif

.PHONY: all clean

all: dist

build:
	mkdir $@

build/mk_fonts_alias: $(CDE_SOURCE_TREE)/programs/fontaliases/mk_fonts_alias.c build
	gcc -o $@ $<

build/mixed.alias: build/mk_fonts_alias build
	./$< 1 > $@

build/google.alias: build/mixed.alias build
	python3 dtfontgen.py $< > $@

dtfonts.ttc:
	./build.sh

dist: build/google.alias dtfonts.ttc
	rm -rf $@
	mkdir $@
	cp build/google.alias $@/fonts.alias
	cp dtfonts.ttc $@
	mkfontscale $@
	mkfontdir $@

clean:
	rm -rf dist build
