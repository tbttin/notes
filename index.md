# Markdowns

What is Markdown? A lightweight markup language that easy to write and
read, optionally convert to other formats.

- [John Gruber's Markdown](markdowns/john-grubers-markdown.md)

- [Pandoc's flavored Markdown](markdowns/pandocs-flavored-markdown.md)

- [CommonMark Spec 0.30](markdowns/commonmark-spec-0.30.md)

- TODO:

  + Change all italics to _this_, bold to this **bold**

  + Try [Github Flavored Markdown](https://github.github.com/gfm/)

  + Not related but how awsome is
    [SVG](https://www.w3schools.com/graphics/svg_intro.asp)?

## `groff`

- What is groff?

- Markdown to pdf which one is better? groff or latex?

# Makefiles

- [GNU `make` manual](makes/gnu-make-manual.md)

# Package management on Arch Linux

- [Arch Build System](package-managament-arch-linux/abs.md)

- [Creating packages](package-managament-arch-linux/creating-packages.md)

- [pacman - binary package manager utility](package-managament-arch-linux/pacman.md)

# Vims

- [Adapting tips and tricks](vims/adapting-tips-and-tricks.md)

- [Favourite tips and tricks](vims/favourite-tips-and-tricks.md)

- TODO: Syntax highlighting

  + There are so many syntax for markdown, vim markdown syntax highlight
    suck.

  + Markdown codelock highlighting? Eh?

# Git

Read more git command manual (it's not so hard, try to find one new
option/thing *every day*).

- [Pro Git v2](git/pro-git-v2.md)

- [Manuals](git/manuals.md)

- [Drafts](git/drafts.md)

# Bash

- TODO: `bash(1)` find useful keybinding (e.g. `M-#` (`Alt-Shift-3`)).

  + Testing:

    ```bash
    bind -m vi -q edit-and-execute-command
    ```

GNU Bash manual.

## Pipelines

A pipeline is a sequence of one or more commands separated by one of the
control operators `|` or `|&`.

## Job control (`jobspecs`)

- See `bash(1)/^JOB CONTROL`.

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

# Command manuals

## Built-in commands

- `type -a <command>` to see types of `command`.

- `<command> --help`

  `help <command>`

  `<command> -?`

  **Or** `man bash` then `/^ +<command> \[` for more detail.

  What the heck about this regex? Where to find regex library docs in my
  system? Answered in [Searching in manual pages].

## Searching for manpages

- `whatis <command>` to see sections, short descriptions of the `command`.

  `man -f <command>` or `man --whatis command`.

- `apropos <text>` search `text` in short description of manpages.

  `man -k <text>` or `man --apropos <text>`.

- `man -K <text>` search `text` in all manpages. Should specify a
  section number.

  `man -wK <text>`

- `whereis` or `man -w -a` locate the binary, source, and manual pages.

- `which` show full path of commands.

## Searching inside a manpage

### `less` as pager

- `less --version` to see what regex library is used.

  `ldd "$(which less)"`

  `./configure --with-regex=?` (it's
  [`PCRE2`](https://www.pcre.org/current/doc/html/pcre2syntax.html) in
  Arch Linux
  [PKGBUILD](https://gitlab.archlinux.org/archlinux/packaging/packages/less/-/blob/main/PKGBUILD))

## Manpage sections

- `ls -d /usr/share/man/man*`

- `man -k intro`

- `man man`

- `printf(1p)`: _p_ mean POSIX manpages.

### On some systems

Some of the following sections are available:

- `0` C library header files

- `9` Kernel routines

- `n` Tcl/Tk keywords

- `x` The X Window System

# systemd

- systemd unit file locations:

  + See `systemd.unit(5)/UNIT FILE LOAD PATH`.

  + `/usr/lib/systemd/system`: installed packages (package manager).

  + `/etc/systemd/system`: installed by system administrator.

  + Run `systemctl show --property UnitPath`.

- `systemctl` is default with `--system`, users use `--user`.

- Edit unit files and avoid conflict with `pacman` see
  [this](https://wiki.archlinux.org/title/systemd#Editing_provided_units)

  + `systemctl edit --full <unit>`

  + `systemctl edit <unit> --drop-in <drop-in-name>`

- Sandboxing:
  [Redhat](https://www.redhat.com/sysadmin/mastering-systemd),
  `systemd-analyze security [unit]`.

- `journalctl(1)` to view unit logs.

## Manuals

- `systemd.directives(7)` Index of configuration directives.

- `systemd.unit(5)`

- `systemd.service(5)`

- `systemd.timer(5)`

- `systemd.special(7)` targets.

- `systemd.exec(5)`

- `systemctl(1)`

- `journalctl(1)`

- `systemd-system.conf(5)`

## Timers

- See `systemd.timer(5)` and `systemd.time(7)`.

- View all started timers: `systemctl list-timers`.

- `OnCalendar` can be tested with `systemd-analyze calendar weekly` or
  `faketime`.

- Timer without `.timer` file (transient timers): `systemd-run(1)`.

## Targets

- [Network online](https://systemd.io/NETWORK_ONLINE/).

  Network targets do *NOT* need `Requires` or `Wants`.

# Linux Foundation's Filesystem Hierarchy Standard (FHS)

- See `hier(7)`: typical Linux filesistem hierarchy.

  + `/media/*` external devices mount point. Arch Linux does not use
    that.

- See `file-hierarchy(7)`, **systemd** system and service manager
  hierarchy.

- Header files and static/dynamic libraries (Arch Linux):

  + `/usr/include/`

  + `/usr/lib/`

    * `stdio.o` is part of C standard library `libc.so`.

    * `ld --verbose | grep SEARCH_DIR`

- [`/bin` link/move/merge to `/usr/bin`
  ](https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/)

## How to classify?

- Some questions that might help to distinguish between the different classes:

  |                       | DATA | CONFIG | STATE | CACHE | RUNTIME |
  |-----------------------|:----:|:------:|:-----:|:-----:|:-------:|
  | sync across machines? | yes? |   yes  |   no  |   no  |    no   |
  | manage in VCS?        |  no  |   yes  |   no  |   no  |    no   |
  | should be backed up?  |  yes |   yes  |  yes  |   no  |    no   |
  | can live in tmpfs?    |  no  |   no   |   no  |  yes  |   yes?  |
  | contains much data?   |  yes |   no   |   no  |  yes  |    no   |

## XDG Base Directory specification

- It's about portable cross-architecture, cross-OS, bla bla.

### User directories

#### `XDG_CONFIG_HOME`

  - Where under-specific *configurations* should be written (analogous to
    `/etc`).

  - Should default to $HOME/.config.

#### `XDG_DATA_HOME`

  - Where user-specific *data files* should be written (analogous to
    `/usr/share`).

  - Should default to `$HOME/.local/share`

  - See more at [Linux
    Foundation](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s11.html)

#### `XDG_STATE_HOME`

  - Where user-specific *state files* should be written (analogous to
    `/var/lib`).

  - Should default to `$HOME/.local/state`

  - State information is generally used to preserve the condition of an
    application (or a group of inter-related applications) between
    invocations and between different instances of the same application.

    * actions history (logs, history, recently used files, …)

    * current state of the application that can be reused on a restart
      (view, layout, open files, undo history, …)

#### `XDG_CACHE_HOME`

  - Where user-specific *non-essential (cached) data* should be written
    (analogous to `/var/cache`).

  - Should default to $HOME/.cache.

#### `XDG_RUNTIME_DIR`

  - See [Arch's
    Wiki](https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories)

#### `$HOME/.local/bin`

Where *user-specific executable files* may store there.

### System directories

- `XDG_DATA_DIRS`

  + List of directories separated by `:`

  + Should default to `/usr/local/share:/usr/share`

- `XDG_CONFIG_DIRS`

  + List of directories separated by `:`

  + Should default to `/etc/xdg`

# Linux booting process

It varies depend on *Unix*-style and computer architecture.

1. System startup

  - Firmware (BIOS or UEFI), POST (Power On Self Test).

  - Search/excute bootloader (GRUP 2, systemd-boot).

2. Boot loader stage

  - First stage bootloader (executed by the firmware).

    + Vendor-specific program code, partition table (MBR).

    + Partition scan.

  - Seconde stage bootloader.

    + Locate kernel on the disk.

    + Insert into memory.

    + Execute with the supplied options.

  - In x86 PC, first- and second-stage bootloaders are combined in to
    GRUP (GRand Unified Bootloader).

3. Kernel stage

  - Decompress itself in place.

  - Perform hardware checks.

  - Gain access to vital peripheral hardware.

  - Run the init process.

4. Init process

  Runlevels:

  - `poweroff.target`, run level 0: turn off (shut down) the computer.

  - `rescue.target`, run level 1: initiate a rescue shell process.

  - `multi-user.target`, run level 3: configure the system as a non-graphical (console) multi-user environment.

  - `graphical.target`, run level 5: establish a graphical multi-user interface with network services.

  - `reboot.target`, run level 6: restart the machine.

  - `emergency.target`: emergency run level.

# X Window System

X server <=> X window manager <=> Clients
    ^
    |
User hardware input

## Articles

- [Window system](https://en.wikipedia.org/wiki/Windowing_system).

- [X window system](https://en.wikipedia.org/wiki/X_Window_System)

## Window manager

- Position

- Appearance

- Move, resize

- Handle keystrokes

### Xlib

- [Xlib - C Language X Interface](https://x.z-yx.cc/libX11/libX11) from X docs.

- [Xlib - C Language X Interface Notes](X/xlib-c-language-x-interface.md) from me.

## X keyboard

TODO: Learn X keyboard extension! Worth it?

X's modifiers and "mode/meta key" in WM, see
[this](https://unix.stackexchange.com/a/119219)

Mode_switch [suck](https://unix.stackexchange.com/a/55154)

[Keyboard input](https://wiki.archlinux.org/title/Keyboard_input)

# Organic farming

- [The One-Straw Revolution - An Introduction to Natural
  Farming](organic-farming/the-one-straw-revolution-an-introduction-to-natural-farming.md)

# Note taking

## Some note picked up when reading wiki.vim docs

- Fast workflow.

  + Open `index.md` file quickly (hotkey or alias).

  + Jump to *link destination* (move to next blank-line, then `bb`)
    and `gf`.

    * `CTRL-^` to switch back.

    * `<Leader>b`

    * `:bf` or `:b1` always switch to `index.md`.

  + Search note quickly.

    * Currently, `index.md` and section folding (well organize) is
      enough.

    * Search and load results into buffers, search in buffers.

    * Quickfix lists.

- Use short notes, link between them.

- Care about note structures? Note subdirectories?

  + Use proper name.

  + Pages? What pages?

- Note then clean/rinse and link to your knowledge or existed notes or
  internet.

## Workflow

- Write markdown in vim.

  + Try to balance between note taking and representation.

- Markdown is markdown, convert to pdf is necessary?

  Can not find the (capable) way to preview/view markdown in vim.

  Convert from *markdown* to *pdf* with `pandoc` (nah `f***` it).

  + `make` is a choice.

  + A lot of cool stuff like highlight link and code, TOC, heading
    number, .etc

- View pdf in `zathura`.

  + TOC

  + Index mode

  + Follow links

## How to take note?

- Take really short notes, include links to read more.

- How to mark what you already know or do not know??

- Recall method?

