- List tracked files in a bare repository (dotfiles):

  ```bash
  config ls-tree --full-tree --name-only -r HEAD
  ```

- Git `log` track moved files:

  ```bash
  git log --follow [--patch] -- filenames
  ```
- git branching strategies vs. trunk-based development?

