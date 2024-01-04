# Manuals

- [ ] [The Scott Chacon and Ben Straub's Pro Git book]

- [x] `gittutorial(7)`

- [x] `gittutorial-2(7)`

  How does Git construct objects to represent project's history?

  + [ ] `git-cat-file(1)`

    `git cat-file -t <SHA-1>`

    `git cat-file commit <SHA-1>`

    `gitrevisions(7)` recap: `git cat-file commit main`

  + [ ] `git-ls-tree(1)`

  How does Git manage `.git/index`?

  + `git ls-files --stage`

  So what our `git add` did was store a new blob and then put a
  reference to it in the index file.

- [ ] `giteveryday(7)`

  + [x] `git-init(1)`

  + [x] `git-log(1)`

  + [x] `git-branch(1)`

    * [x] `git-check-ref-format(1)`

  + [x] `git-add(1)`

  + [x] `git-merge(1)`

  + [x] `git-remote(1)`

  + [x] `git-checkout(1)`

  + [x] `git-switch(1)`

  + [x] `git-restore(1)`

  + [x] `git-reset(1)`

    * `git reset [<tree-ish>] <pathspec>` resets the index.

    * `git reset <commit>` move branch.

  + [x] `git-status(1)`

    * Show untracked file in a large project, see `git update-index
      --untracked-cache` and `git update-index --split-index`

  + [x] `git-diff(1)`

- [ ] [Git User's Manual]

- [x] `git(1)`

  + [ ] `/^GUIDES`

- [x] `gitcli(7)`

- [x] `gitrepository-layout(5)`

- [x] `gitrevisions(7)`

- [x] `gitglossary(7)`

  + `pathspec`

- [ ] `gitworkflows(7)`

- [ ] `gitcore-tutorial(7)`

  + [ ] `git-update-index(1)`

  + [ ] `git-diff-files(1)`

  + [ ] `git-write-tree(1)`

  + [ ] `git-commit-tree(1)`

  + [ ] `git-update-ref(1)`

  + [ ] `git-diff-index(1)`

  + [ ] `git-diff-tree(1)`

  + [ ] `git-ref-list(1)`

  + [ ] `git-read-tree(1)`

  + [ ] `git-checkout-index(1)`

  + [ ] `git-show-branch(1)`

  HOW DOES MERGE WORK?

  + [ ] `git-merge-base(1)`

  + [ ] `git read-tree -m -u $mb HEAD mybranch`

  + [ ] `git-ls-files(1)`

    How to inspect merge conflict?

    `git ls-files --stage`

    `git ls-files --unmerged`

  + [ ] `git-merge-index(1)`

  PUBLISHING YOUR WORK

  + [ ] `git-send-pack(1)`

  + [ ] `git-recieve-pack(1)`

  PACKING YOUR REPOSITORY

  + Optimization for objects transportation over the network.

  + [ ] `git-repack(1)`

  + [ ] `git-prune-packed(1)`

  + [ ] `git-verify-pack(1)`

  + [ ] `git-count-objects(1)`

[The Scott Chacon and Ben Straub's Pro Git book]:
https://git-scm.com/book

[Git User's Manual]:
https://git-scm.com/docs/user-manual

# `commit`

- `-a` auto stage all modified and deleted files.

# `git-stash(1)`

  + Save all changes in the working tree and the index, roll them back
    to HEAD.

  + `-k`, `--keep-index`, `--no-keep-index` do not stash the index.

  + `-S`, `--staged` stash only the index.

  + `--index` reinstate the index (`pop` and `apply`).

  + `/^EXAMPLES` some really good examples.

# `gitcli(7)`

- The ambiguous between revision and file name (*HEAD*):

  + File name: `git diff -- HEAD`

  + Revision: `git diff HEAD --`

  `--end-of-options`

  `master^0`

  Full ref 'refs/heads/master' vs. relative to `.` path `./master`?

# `git-work-tree(1)`

