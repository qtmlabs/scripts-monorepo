ifndef CDE_SOURCE_TREE
$(error CDE_SOURCE_TREE must be set to CDE source path)
endif

.PHONY: all clean

all: package

mk_fonts_alias: $(CDE_SOURCE_TREE)/programs/fontaliases/mk_fonts_alias.c
	gcc -o $@ $<

mixed.alias: mk_fonts_alias
	./$< 1 > $@

google.alias: mixed.alias
	python3 dtfontgen.py $< > $@

dtfonts.ttc:
	./build.sh

package: google.alias dtfonts.ttc
	rm -rf $@
	mkdir $@
	cp google.alias $@/fonts.alias
	cp dtfonts.ttc $@
	mkfontscale $@
	mkfontdir $@

clean:
	rm -rf package mixed.alias google.alias mk_fonts_alias
