PARSER := /usr/bin/pandoc

markdowns := $(wildcard */*.md)
pdfs      := $(markdowns:%.md=%.pdf)
rm        := /usr/bin/rm --force --

all: $(pdfs)

%.pdf: %.md
	$(PARSER) $< -o $@

clean-pdf:
	$(rm) $(pdfs)

.PHONY: all clean-pdf

$(info $(patsubst %.pdf,out/%,$(pdfs)))
