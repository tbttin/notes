# Miscellany

- List tracked files in a bare repository (dotfiles):

  ```bash
  config ls-tree --full-tree --name-only -r HEAD
  ```

- Git `log` track moved files:

  ```bash
  git log --follow [--patch] -- <filenames>
  ```
- Git branching strategies vs. trunk-based development?

# Manuals

- How to read Git manuals:

  + [The Scott Chacon and Ben Straub's Pro Git book]

  + `git(1)`

    `/^GUIDES`

  + `gitcli(7)`

  + `gittutorial(7)`

    `gittutorial-2(7)`

  + [Git User's Manual]

  + `giteveryday(7)`

    * `git-init(1)`

    * `git-add(1)`

    * `git-merge(1)`

  + `gitworkflows(7)`

[The Scott Chacon and Ben Straub's Pro Git book]:
https://git-scm.com/book

[Git User's Manual]:
https://git-scm.com/docs/user-manual

# Command-line interface

- `gitcli(7)`

- The ambiguous between revision and file name (*HEAD*):

  + File name: `git diff -- HEAD`

  + Revision: `git diff HEAD --`

  `--end-of-options`

  Full ref 'refs/heads/master' vs. full path `./master`?
