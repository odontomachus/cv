LANG ?= en_US
LLANG = $(firstword $(subst ., ,$(LANG)))
LCODE = $(firstword $(subst _, ,$(LLANG)))

all: generate

pot: tpl/cv.html
	xgettext -o i18n/cv.pot -d cv --language=Python --from-code=utf-8 tpl/cv.html

%.po: pot
	msgmerge -N -U i18n/$(LLANG)/cv.po i18n/cv.pot

%.mo: %.po
	msgfmt -c -v -o i18n/$(LLANG)/LC_MESSAGES/cv.mo i18n/$(LLANG)/cv.po

generate: $(LCODE).mo tpl/cv.html
	python cv.py $(LCODE) index-$(LCODE).html
	rm index.html
	ln -s index-$(LCODE).html index.html
