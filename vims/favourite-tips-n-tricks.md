- TODO: Read every command manual carefully (again, maybe).

  + `a` does take `[count]`, `3a.`: insert three dots.

  + `v` and `r` do take `[count]` too.

# Miscellany

- Doing some external command line works:

  + `:sh[ell]`, or

  + `CTRL-Z`, `fg [job spec]`, `bg [job spec]`

- The generic names for the *filetype plugins* are:

  `ftplugin/<filetype>.vim`\
  `ftplugin/<filetype>_<name>.vim`\
  `ftplugin/<filetype>/<name>.vim`

- Sometimes you will see a split column number. For example, "col 2-9".

  This indicates that the cursor is positioned on the *second*
  character, but because character one is a *tab*, occupying eight
  spaces worth of columns, the screen column is 9 (2nd character, 9th
  column).

# Helps

## Manuals

- Indexes and quickrefs: `:h index<C-D>`, `:h Q_<C-D>`

- Manuals: help-summary, user-manual, usr_toc, reference_toc, helphelp,
  option-summary, index (alphabet order), quickref (feature order),
  motion, terminal, windows, tabs, packages, pattern, vimdiff,
  diffpatch, undo, tips, spell, .etc

- Lists: jumplist, changes, tags, quickfix, buffers, arguments,
  location-list, function-list, .etc

- Startup/initialization:

  + `:h[elp] startup`

  + `:scr[iptnames]`

  + `:verb[ose] set/map {option/map?}` " No ouput mean default setting.

  See also *profiling* in [Command-line commands].

- Options:

  + `:opt[ions]`

  + `:se[t]`         show all modified options\
    `:se[t] all`     show all non-termcap options\
    `:se[t] termcap` show all termcap options

# Searching

- Helps:

  + Regex items always start with a slash `:h /\+`

  + Substitute items always start with an `s/` `:h s/\&`

- Search non-ASCII characters: `/\v[^\d0-\d127]`. See '`/\]`'.

- Search inside *visual* area: `/\%Vfoo.*bar\%V`.

- Operator + search motion: `d/[regex]`

  + Combine with `.`, '`last-pattern`', `n` (also '`gn`'), '`{offset}`'.

  + Can be switched to *line-wise* motion with `dV`. See '`o_V`'.

  + Jump around matches with '`/_CTRL-G`' and '`/_CTRL-T`'.

- `/{regex}/`: do the nomal search but remove old offset.

- '`//;`': a special offet "search after search":

   `/test 1/;/test`\
   `/test.*/+1;?ing?`

  The first one first finds the next occurrence of "test 1", and then
  the first occurrence of "test" after that.

- The power of `:g[lobal]` command:

  + Search and replace in in ranges determined by *global search*:

    ````vim
    :g/```.\+/+1,/```/-1s/^  //gce

    ````

    will remove two spaces of internal indentation of every fenced code
    block in markdown file.

    `+N`, `-N`: if the `N` is omitted, 1 is used (See '`range`').

    Look back and look forward?

- `c_CTRL-R_CTRL-W`: insert/complete the word under the cursor. Se also
  `/_CTRL-L`

- `\%(\)`: just like `\(\)`, but without counting it as a
  sub-expression.

  This allows using more groups and it's a little bit *faster*.

# Command-line commands

Command-line command = Ex commands = Colon commands

- Helps: cmdline, cmdline-completion, cmdline-special,
  filename-modifiers, .etc

- Edit *cmdline commands* just like any other buffer:
  '`cmdline-window`', `c_CTRL-F`, `q:`, `q?` and `q/`.

  + `o<CR>` to cancel and exit cmdline window (submit a empty line).

- `:cq[uit]` quit Vim with error code `{N}`. `{N}` defaults to one.

  Useful when Vim is called from another program: e.g., a compiler
  will not compile the same file again, `git commit` will abort the
  committing process, `fc` (built-in for shells like bash and zsh)
  will not execute the command, etc.

- Redirect ex command output:

  ```vim
  :redi[r] @+
  :command
  ...
  :redi[r] END
  ```

 - '`more-prompt`' or '`hit-enter`': if you accidentally hit `<Enter>`
   or `<Space>` and you want to see the displayed text then use `g<`.

   This only works when '`more`' is set.

- Profiling:

  ```vim
  :prof[ile]
  ```

  ```bash
  vim --startuptime vim.log
  ```

- `:e[dit]!` will revert to the latest *saved* version of the current
  file.

- Transfer text, they do *not* use registers.

  `:co[py] {address}`\
  `:t {address} " Same as :copy`\
  `:m[ove] {address}`

- `:w !shell_cmd` mean pipe the contents of the current buffer to the
  command `shell_cmd`, e.g. `:w !sudo tee %` (a.k.a. the write with
  *sudo* trick).

- Option completion `:set option=<Tab>`

## Buffers

- The file you were previously editing is called the *alternate* file.

  Notice that the `CTRL-^` command does not change the idea of *where*
  you are in the list of files?

  Only commands like "`:n[ext]`" and "`:prev[ious]`" do that.

- Buffer name expansion trick:

  `:ls [flags]`\
  `:bd 1 2 3`\
  `:bd *<C-A>`

- Save the current buffer under the name `{file}` and set the filename
  of the current buffer to `{file}`.

  `:sav[eas][!] [++opt] {file}`

# Normal mode commands

- '`blockwise-operators`'

  + '`v_b_I`' insert the same text in front of all the selected lines.

  + '`v_b_A`' append the same text after all the selected lines.

  + '`v_b_C`' (part of a paragraph) like using "c", but the selection is
    extended until the end of the line for all lines.

  Usage: [un]comment, "quoting", .etc

- `gv`: start visual mode with the same area as the previous area and
  the *same* mode.

  *After* using "p" or "P" in visual mode the text that was put will be
  selected.

- `1v` or `{count}v` selects an area equal to the previous visual.

  Note that this will only work if you actually did something to the
  previous visual selection, such as a yank, delete, or change
  operation.

- Just recall, '`wrap`'ed long line:

  + `g0` to first visible character in this line

  + `g^` to first non-blank visible character in this line

  + `gm` to middle of screen line

  + `gM` to middle of the text in this line

  + `g$` to last visible character in this line

- `ge`: backward to the end of word `[count]` (vs `be` from middle
  word?).

- `g_`: to the last non-blank character of the line.

- `ga`: print the ASCII value of the character under the cursor in decimal,
  hexadecimal and octal.

- '`change-list-jump`':

  + `gi`: enter insert mode in last insert location, jump around and
    "`gi`-boom"!

  + `g; [count]` go to the older position, `g, [count]` go to the newer.

- Paste/put:

  + `]p` (just like "`p`") and `[p` (just like "`P`"), but adjust the
    indent to the current line.

  + `gp` and `gP` also put the text before or after the current line,
    but they leave the cursor positioned at the *end* of the pasted
    text.

- `{count}` + range ('`N:`'): `N:` is translated into `:.,.+(count - 1)`

- Recursive/appended macros:

  `qM@mq`\
  `@m`

