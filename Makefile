#EXTENDED=yes

ifeq ($(EXTENDED),)
   OPTS = 
else
   OPTS = -a extended
endif


OPTS:=$(OPTS) -a revdate="$(shell date +"%d %B, %Y")" --failure-level WARN -v

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	WATCHCMD=fswatch -r -e '\.swp' -e '\.git' -e build . | xargs -n1 -I{} make html
else
	WATCHCMD=inotifywait -q -m -r --format gotchange --exclude '\.swp' --exclude '\.git' --exclude build -e modify | xargs -n1 -I{} make html
endif

all: prepare html pdf

.PHONY: prepare
prepare:
	mkdir -p build
	bundle install
	bundle binstubs --all

html:
	bundle exec asciidoctor -r ./lib/stats.rb -a html $(OPTS) -b html5 -a docinfo=shared -o build/nxsl.html index.adoc

pdf:
	#asciidoctor-pdf -a pdf-style=netxms-theme.yml -a pdf-fontsdir=fonts -o build/nxsl.pdf index.adoc
	bundle exec asciidoctor-pdf -o build/nxsl.pdf index.adoc

docbook:
	bundle exec asciidoctor -r ./lib/stats.rb -b docbook -o build/nxsl.docbook index.adoc

clean:
	rm -rf build/nxsl.pdf build/nxsl.html

watch:
	$(WATCHCMD)
