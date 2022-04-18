PARSER    := /usr/bin/pandoc
PFLAGS    := --from=commonmark\
	     --number-sections\
	     --toc\
	     --variable=colorlinks\
	     --highlight-style=tango\
	     --columns=79
MAKEFLAGS += --no-builtin-rules\
	     --no-builtin-variables

out_dir     := notes-output
pdf_dir     := $(out_dir)/pdf
markdowns   := $(wildcard *.md */*.md)
pdf_targets := $(addprefix $(pdf_dir)/,$(markdowns:%.md=%.pdf))
pdf_subdirs := $(sort $(dir $(pdf_targets)))
mkdir       := @/usr/bin/mkdir --parents --
rm          := @/usr/bin/rm --force --recursive --verbose --

all: $(pdf_targets)

.SECONDEXPANSION:
$(pdf_dir)/%.pdf: %.md | $$(@D)/
	$(PARSER) $(PFLAGS) -o $@ -- $<

$(pdf_subdirs):
	$(mkdir) $@

clean-pdf:
	$(rm) $(pdf_dir)

clean: clean-pdf

.PHONY: all clean-pdf clean

# Debugging makefile
# $(info $(markdowns))

