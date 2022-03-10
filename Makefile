PARSER := /usr/bin/pandoc
PFLAGS := --from=commonmark

markdowns   := $(wildcard */*.md)
out_dir     := output
pdf_dir     := $(out_dir)/pdf
pdf_targets := $(addprefix $(pdf_dir)/, $(markdowns:%.md=%.pdf))
topic_dirs  := $(sort $(dir $(pdf_targets)))
mkdir       := @/usr/bin/mkdir --parents
rm          := @/usr/bin/rm --force --recursive --verbose --

all: $(pdf_targets)

# Order-only prerequisite. Automatic variables beat me. Any better ideas?
$(pdf_dir)/%.pdf: %.md | $(topic_dirs)
	$(PARSER) $(PFLAGS) -o $@ -- $<

$(topic_dirs):
	$(mkdir) $@

clean-pdf:
	$(rm) $(pdf_dir)/*

.PHONY: all clean-pdf

# $(info $(topic_dirs))
