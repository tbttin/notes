# Dotfiles

## Initialization

1. Initialize a bare repo:

   ```bash
   git init --bare "$HOME/.config/dotfiles.git"
   ```

2. Create `config` alias:

   ```bash
   echo "alias config='/usr/bin/git \
     --git-dir=\$HOME/.config/dotfiles.git \
     --work-tree=\$HOME'" >> ~/.bashrc
   source ~/.bashrc
   ```

3. Config `dotfiles.git` to not show *untracked files*:

   ```bash
   config config --local -- status.showUntrackedFiles no
   ```

## Usages

- Add -- commit -- push:

  ```bash
  config add ~/.bashrc
  config commit -m "Add 'bashrc'"
  config remote add origin 'https://host/path/to/repo.git'
  config push --set-upstream origin
  ```

## Re-installation

- Clone dotfile repo:

  ```bash
  config clone --bare 'https://host/path/to/repo.git' \
    "$HOME/.config/dotfiles.git"
  ```

- Checkout dotfiles to home (logged out and backed up conflict files):

  ```bash
  config checkout
  ```

- Or

  ```bash
  curl --silent --location 'https://shortened-url-script' |
    /usr/bin/bash
  ```

## Bla bla

- List tracked files in a bare repository:

  ```bash
  config ls-tree --full-tree --name-only -r HEAD
  ```

# Miscellany

- Git `log` track moved files:

  ```bash
  git log --follow [--patch] -- <filenames>
  ```
- Create remote repository:

  ```bash
  mkdir my-git.git
  cd my-git.git
  GIT_DIR=. git init
  ```

- Git branching strategies vs. trunk-based development?

- *Symbolic ref* is a ref that point to another ref.

  A symbolic ref is a regular file that stores a string that begins with
  `ref: refs/`.

