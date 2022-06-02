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

- *Symbolic ref* is a ref that point to another ref.

  A symbolic ref is a regular file that stores a string that begins with
  `ref: refs/`.

