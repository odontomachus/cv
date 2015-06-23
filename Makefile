LANG ?= en_US
LLANG = $(firstword $(subst ., ,$(LANG)))
LCODE = $(firstword $(subst _, ,$(LLANG)))

all: generate

pot: html/cv.html
	xgettext -o i18n/cv.pot -d cv --language=Python --from-code=utf-8 html/cv.html

%.po: pot
	msgmerge -N -U i18n/$(LLANG)/cv.po i18n/cv.pot

%.mo: %.po
	msgfmt -c -v -o i18n/$(LLANG)/LC_MESSAGES/cv.mo i18n/$(LLANG)/cv.po

generate: $(LCODE).mo html/cv.html
	python cv.py $(LCODE) index.html
