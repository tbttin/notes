# Manuals

- [ ] [The Scott Chacon and Ben Straub's Pro Git book]

- [x] `git(1)`

  + [ ] `/^GUIDES`

- [x] `gitcli(7)`

- [x] `gitrevisions(7)`

- [x] `gitglossary(7)`

- [x] `gittutorial(7)`

- [ ] `gittutorial-2(7)`

  + [ ] `git-cat-file(1)`

    `git cat-file -t <SHA-1>`

    `git cat-file commit <SHA-1>`

    `gitrevisions(7)` recap: `git cat-file commit main`

  + [ ] `git-ls-tree(1)`

- [ ] [Git User's Manual]

- [ ] `giteveryday(7)`

  + [x] `git-init(1)`

  + [x] `git-add(1)`

  + [x] `git-merge(1)`

- [ ] `gitworkflows(7)`

- [ ] `gitcore-tutorial(7)`

[The Scott Chacon and Ben Straub's Pro Git book]:
https://git-scm.com/book

[Git User's Manual]:
https://git-scm.com/docs/user-manual

# `git-stash(1)`

  + Save all changes in the working tree and the index, roll them back
    to HEAD.

  + `-k`, `--keep-index`, `--no-keep-index` do not stash the index.

  + `-S`, `--staged` stash only the index.

  + `--index`?

  + `/^EXAMPLES` some really good examples.

# `git-reflog(1)`

# `gitcli(7)`

- The ambiguous between revision and file name (*HEAD*):

  + File name: `git diff -- HEAD`

  + Revision: `git diff HEAD --`

  `--end-of-options`

  `master^0`

  Full ref 'refs/heads/master' vs. full path `./master`?
