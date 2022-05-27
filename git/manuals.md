# Manuals

- How to read Git manuals:

  + [The Scott Chacon and Ben Straub's Pro Git book]

  + `git(1)`

    `/^GUIDES`

  + `gitcli(7)`

  + `gitrevisions(7)`
  
  + `gitglossary(7)`

  + `gittutorial(7)`

    `gittutorial-2(7)`

  + [Git User's Manual]

  + `giteveryday(7)`

    * `git-init(1)`

    * `git-add(1)`

    * `git-merge(1)`

  + `gitworkflows(7)`

  + `gitcore-tutorial(7)`

[The Scott Chacon and Ben Straub's Pro Git book]:
https://git-scm.com/book

[Git User's Manual]:
https://git-scm.com/docs/user-manual

# `git-stash(1)`

  + Save all changes in the working tree and the index, roll them back
    to HEAD.

  + `-k`, `--keep-index`, `--no-keep-index` do not stash the index.

  + `-S`, `--staged` stash only the index.

  + `/^EXAMPLES` some really good examples.

  + `--index`?

# `git-reflog(1)`

# `gitcli(7)`

- The ambiguous between revision and file name (*HEAD*):

  + File name: `git diff -- HEAD`

  + Revision: `git diff HEAD --`

  `--end-of-options`

  `master^0`

  Full ref 'refs/heads/master' vs. full path `./master`?
