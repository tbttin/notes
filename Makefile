PARSER    := /usr/bin/pandoc
PFLAGS    := --variable=colorlinks\
	     --toc\
	     --number-sections\
	     --from=commonmark
MAKEFLAGS += --no-builtin-rules\
	     --no-builtin-variables

out_dir     := notes-output
pdf_dir     := $(out_dir)/pdf
markdowns   := $(wildcard */*.md)
pdf_targets := $(addprefix $(pdf_dir)/,$(markdowns:%.md=%.pdf))
topic_dirs  := $(sort $(dir $(pdf_targets)))
mkdir       := @/usr/bin/mkdir --parents --
rm          := @/usr/bin/rm --force --recursive --verbose --

all: $(pdf_targets)

# Order-only prerequisite. Automatic variables beat me. Any better ideas?
$(pdf_dir)/%.pdf: %.md | $(topic_dirs)
	$(PARSER) $(PFLAGS) -o $@ -- $<

$(topic_dirs):
	$(mkdir) $@

clean-pdf:
	$(rm) $(pdf_dir)

clean: clean-pdf

.PHONY: all clean-pdf clean

# $(info $(topic_dirs))

