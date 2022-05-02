TODO: Read every command manual (again, maybe).

# Miscellany

- `ga`: print the ASCII value of the character under the cursor in decimal,
  hexadecimal and octal.

- Doing some external command line works:

  + `:shell`

  + `CTRL-z`, `fg [job spec]`, `bg [job spec]`

- The generic names for the *filetype plugins* are:

  `ftplugin/<filetype>.vim`\
  `ftplugin/<filetype>_<name>.vim`\
  `ftplugin/<filetype>/<name>.vim`

- Save and exit quickly:

  + `ZZ` a faster version of `:wq` (same as `:x`)

  + `ZQ` a faster version of `:q!`

# Helps

## Manuals

- Indexes: `:h index<C-D>`

- Manuals: user-manual, usr_toc, reference_toc, help-summary, helphelp,
  option-summary, index (alphabet order), quickref (feature order),
  terminal, windows, tabs, packages, pattern, vimdiff, diffpatch, undo,
  tips, spell, .etc

- Lists: jumplist, changes, tags, quickfix, buffers, arguments,
  location-list, function-list

- Startup/initialization:

  + `:help startup`

  + `:scriptnames`

  + `:verb set {option?}` " No ouput mean using default setting.

  See also *profiling* in [Command-line commands].

- Options:

  + `:options`

  + `:se[t]`         show all modified options
    `:se[t] all`     show all non-termcap options
    `:se[t] termcap` show all termcap options

# Searching

- Search non-ASCII characters: `/\v[^\d0-\d127]`

- The power of `:global`

  + Search and replace in in ranges determined by *global search*:

    ````vim
    :g/```.\+/+1,/```/-1s/^  //gce
    ````
    Look back and look forward?

- `c_CTRL-r_CTRL-w`: insert/complete the word under the cursor. Se also:
  `/_CTRL-l`

# Command-line commands

Command-line command = Ex commands = Colon commands

- Helps: cmdline, cmdline-completion, cmdline-special,
  filename-modifiers

- `:cquit` quit Vim with error code `{N}`. `{N}` defaults to one.

  Useful when Vim is called from another program: e.g., a compiler
  will not compile the same file again, `git commit` will abort the
  committing process, `fc` (built-in for shells like bash and zsh)
  will not execute the command, etc.

- Redirect ex command output:

  ```vim
  :redir @+
  :command
  ...
  :redir END
  ```

- If you accidentally hit `<Enter>` or `<Space>` and you want to see the
  displayed text then use `g<`.

  This only works when '`more`' is set.

  '`more-prompt`' '`hit-enter`'

- Profiling:

  ```vim
  :profile
  ```

  ```bash
  vim --startuptime vim.log
  ```

- `:edit!` will revert to the latest *saved* version of the current
  file.

- Transfer text, they do *not* use registers.

  `:co[py] {address}`\
  `:t {address}`\
  `:m[ove] {address}`

- `:w !shell_cmd` mean pipe the contents of the current buffer to the
  command `shell_cmd`, e.g. `:w !sudo tee %` (a.k.a. the write with
  `sudo` trick).

## Buffers

- The file you were previously editing is called the *alternate* file.

  Notice that the `CTRL-^` command does not change the idea of *where*
  you are in the list of files?

  Only commands like "`:next`" and "`:previous`" do that.

- Buffer name expansion trick:

  `:ls`\
  `:bd 1 2 3`\
  `:bd *<C-A>`

- Save the current buffer under the name `{file}` and set the filename
  of the current buffer to `{file}`.

  `:sav[eas][!] [++opt] {file}`

# Normal mode commands

- '`blockwise-operators`'

  + '`v_b_I`' insert the same text in front of all the selected lines

  + '`v_b_A`' append the same text after all the selected lines

  + '`v_b_C`' (part of a paragraph) like using "c", but the selection is
    extended until the end of the line for all lines.

  Usage: [un]comment, "quoting", .etc

- `gv`: start Visual mode with the same area as the previous area and
  the *same* mode.

  *After* using "p" or "P" in Visual mode the text that was put will be
  selected.

- `1v` or `{count}v` selects an area equal to the previous visual.

  Note that this will only work if you actually did something to the
  previous visual selection, such as a yank, delete, or change
  operation.

- Just recall: '`wrap`'

  + `g0` to first visible character in this line

  + `g^` to first non-blank visible character in this line

  + `gm` to middle of screen line

  + `gM` to middle of the text in this line

  + `g$` to last visible character in this line

  + And `ge`: backward to the end of word `[count]`.

