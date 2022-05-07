# Markdowns

- [John Gruber's Markdown](markdowns/john-grubers-markdown.md)

- [Pandoc's flavored Markdown](markdowns/pandocs-flavored-markdown.md)

- [CommonMark Spec 0.30](markdowns/commonmark-spec-0.30.md)

# Makefiles

- [GNU `make` manual](makes/gnu-make-manual.md)

# Package management on Arch Linux

- [makepkg - package build utility](package-managament-arch-linux/makepkg.md)

- [pacman - package manager utility](package-managament-arch-linux/pacman.md)

- [namcap - package analysis utility](package-managament-arch-linux/namcap.md)

# Vims

- [Vim tips and tricks](vims/favourite-tips-n-tricks.md)

# `groff`

- What is groff?

- Markdown to pdf which one is better? groff or latex?

# Git

- List tracked files in a bare repository (dotfiles):

  ```bash
  config ls-tree --full-tree --name-only -r HEAD
  ```

- Git `log` track moved files:

  ```bash
  git log --follow [--patch] -- filenames
  ```

# Note taking

## Reading wiki.vim docs

- Fast workflow.

  + Open `index.md` file quickly (hotkey or alias).

  + Jump to *link destinition* (move to the line, `$`, and back) then `gf`.

    * `CTRL-^` to switch back.

    * `:bf` or `:b1` always switch to `index.md`.

  + Search note quickly.

    * Search and load results into buffers, search in buffers.

    * Quickfix lists.

- Pages? Short pages?

- Care about note structures? Note subdirectories?

  + Use proper name.

  + Pages? What pages?

- Note then clean/rinse and link to your knowledge or existed notes or
  internet.

