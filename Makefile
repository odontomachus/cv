LANG ?= en_US
LLANG = $(firstword $(subst ., ,$(LANG)))
LCODE = $(firstword $(subst _, ,$(LLANG)))

all: pdf

pdf: html
	cp cv-$(LCODE).html cv-$(LCODE).html.o
	sed -i 's,href="/,href=",g' cv-$(LCODE).html.o
	weasyprint cv-$(LCODE).html.o --base-url . -s css/print.css -s vendor/Skeleton/css/normalize.css -s vendor/Skeleton/css/skeleton.css cv-$(LCODE).pdf
	rm cv-$(LCODE).html.o

pot: tpl/cv.html
	xgettext -o i18n/cv.pot -d cv --language=Python --from-code=utf-8 tpl/cv.html

%.po: pot
	msgmerge -N -U i18n/$(LLANG)/cv.po i18n/cv.pot

%.mo: %.po
	msgfmt -c -v -o i18n/$(LLANG)/LC_MESSAGES/cv.mo i18n/$(LLANG)/cv.po

html: $(LCODE).mo tpl/cv.html
	python cv.py $(LCODE) cv-$(LCODE).html
	rm index.html
	ln -s cv-$(LCODE).html index.html
