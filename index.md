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

- [Favourite tips and tricks](vims/favourite-tips-and-tricks.md)

- [Adapting tips and tricks](vims/adapting-tips-and-tricks.md)

# `groff`

- What is groff?

- Markdown to pdf which one is better? groff or latex?

# Git

Read more git command manual (it's not so hard, try to find one new
option/thing *every day*).

- [Pro Git v2](git/pro-git-v2.md)

- [Notes](git/notes.md)

# Bash

GNU Bash manual.

## Pipelines

A pipeline is a sequence of one or more commands separated by one of the
control operators '|' or '|&'.

## Jobspecs

- This

  ```bash
  [1] 25647
  ```

  indicating that this job is job number 1 and that the process [ID] of
  the last process in the pipeline associated with this job is 25647.

- There are a number of ways to refer to a job in the shell. The
  character '`%`' introduces a job specification (`jobspec`).

  Job number `n` *may* be referred to as '`%n`'.

  The symbols '`%%`' and '`%+`' refer to the shell's notion of the
  current job, which is the last job stopped while it was in the
  foreground or started in the background.

  A single '`%`' (with no accompanying job specification) also refers to
  the current job.

  The previous job may be referenced using '`%-`'. If there is only a
  single job, '`%+`' and '`%-`' can both be used to refer to that job.

  In output pertaining to jobs (e.g., the output of the `jobs` command),
  the current job is always flagged with a '`+`', and the previous job
  with a '`-`'.

- A job may also be referred to using a prefix of the name used to start
  it, or using a substring that appears in its command line.

  For example, '`%ce`' refers to a stopped job whose command name begins
  with '`ce`'.

  Using '`%?ce`', on the other hand, refers to any job containing the
  string '`ce`' in its command line. If the prefix or substring matches
  more than one job, Bash reports an error.

- Simply naming a job can be used to bring it into the foreground:
  '`%1`' is a synonym for '`fg %1`', bringing job 1 from the background
  into the foreground. Similarly, '`%1 &`' resumes job 1 in the
  background, equivalent to '`bg %1`'.

# Command-line manuals

## Built-in commands

- `<command> --help`

  `help <command>`

  `<command> -?`

  **Or** `man bash` then `/^  +<command> \[` for more detail.

  What the heck about this regex? Where to find regex library docs in my
  system? Answered in [Searching in manual pages].

## Searching

- `type -a <command>` to see types of `command`.

- `whatis <command>` to see sections, short descriptions of the `command`.

  `man -f <command>` or `man --whatis command`.

- `apropos <keyword>` search `keyword` in short description of manpages.

  `man -k <keyword>` or `man --apropos <keyword>`.

## Searching in manual pages

### `less` as pager

- `less --version` to see what regex library is used.

  `ldd "$(which less)"`

  `./configure --with-regex=?` (['`pcre2`' in Arch Linux])

['`pcre2`' in Arch Linux]:
https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/less/trunk/PKGBUILD

# Note taking

## Some note picked up when reading wiki.vim docs

- Fast workflow.

  + Open `index.md` file quickly (hotkey or alias).

  + Jump to *link destination* (move to the line, `$`, and back) then `gf`.

    * `CTRL-^` to switch back.

    * `:bf` or `:b1` always switch to `index.md`.

  + Search note quickly.

    * Currently, index.md and section folding in note file (well
      organize) is enough.

    * Search and load results into buffers, search in buffers.

    * Quickfix lists.

- Pages? Short pages?

- Care about note structures? Note subdirectories?

  + Use proper name.

  + Pages? What pages?

- Note then clean/rinse and link to your knowledge or existed notes or
  internet.

## Workflow

- Write markdown in vim.

  + Try to balance between note taking and representation.

- Can not find the (capable) way to preview/view markdown in vim.
  Convert from *markdown* to *pdf* with `pandoc`.

  + `make` is a choice.

  + A lot of cool stuff like highlight link and code, TOC, heading
    number, .etc

- View pdf in `zathura`.

  + TOC

  + Index mode

  + Follow links

## How to take note?

- How to mark what you already know or do not know?

- Recall

