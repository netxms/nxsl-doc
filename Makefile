all: prepare html pdf

prepare:
	mkdir -p build

html:
	asciidoctor -b html5 -o build/nxsl.html index.adoc

pdf:
	#asciidoctor-pdf -a pdf-style=netxms-theme.yml -a pdf-fontsdir=fonts -o build/nxsl.pdf index.adoc
	asciidoctor-pdf -o build/nxsl.pdf index.adoc

clean:
	rm -rf build/nxsl.pdf build/nxsl.html
