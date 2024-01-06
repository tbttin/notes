# Query package information

- You can use pacman's query functions to display a list of files
  contained in the package and the dependencies it requires with:

  ```bash
  pacman --query --list --file=<pkgname-pkgver.pkg.tar.zst>
  # or
  pacman --query --info --file=<pkgname-pkgver.pkg.tar.zst>
  # or
  pacman --query --list <installed-package>
  # or
  pacman --query --info <installed-package>
  ```

- Query explicit installed packages: `pacman -Qqe`.

- `/var/lib/pacman/local/pkgname` is where pacman save package
  informaiton like:

  + Installed files.

  + Package description.

- Find which package holds `filename`:

  ```bash
  pacman --query --owns <filename>
  # or
  pacman --files --refresh <filename>
  ```

- List *modified* configuration files:

  ```bash
  pacman --query --info --info | grep ^MODIFIED | cut --fields=2
  ```

- Package dependencies tree `pactree(8)`.

- `pacman --sync --search` has builtin ERE.

  `pacman -Ss '^vim-'`

# Cleanings

## Cache cleaning

- Pacman stores its downloaded packages in `/var/cache/pacman/pkg`.

- You can also define how many recent versions you want to keep. To
  retain only one past version use:

  ```bash
  doas paccache -rk1
  ```

## Removing unused packages (orphans)

- Recursively removing orphans and their configuration files:

  ```bash
  pacman -Qtdq | doas pacman -Rns -
  ```

# Hooks

- Pacman can run pre- and post-transaction hooks from the
  `/usr/share/libalpm/hooks/` directory.

- See `HookDir` option in `/etc/pacman.conf`, which defaults to
  `/etc/pacman.d/hooks`

- See `alpm-hooks(5)`

- Some recommended hook ideas: ranking mirrors, list installed packages,
  list system modified files.

  Clean up cache (or `paccache.timer` service), remove orphan packages.

  See [reddit
  post](https://www.reddit.com/r/archlinux/comments/dsnu81/hear_ye_archers_share_your_pacman_hooks)

# Mirror list

- Ranking mirror list (`pacman-contrib` package is required):

  ```bash
  curl -s 'https://archlinux.org/mirrorlist/' \
          -d 'country=all' \
          -d 'protocol=https' \
          -d 'ip_version=4' \
          -d 'ip_version=6' \
          -d 'use_mirror_status=on' |
          sed -e 's/^#Server/Server/' -e '/^#/d' |
          rankmirrors -n 6 - > ~/mirrorlist &
  ```

  Or automatically on pacman's PostTransaction:
  [mirrorlist-rankmirrors-hook](https://aur.archlinux.org/packages/mirrorlist-rankmirrors-hook)
  from AUR.

- Installing packages on bad connection? `--disable-download-timeout`

# Log file

- Pacman log file can be found in `/var/log/pacman.log`.

- Packages install/update history:

  ```bash
  grep "\(upgraded\|installed\) $pkg" /var/log/pacman.log
  ```

- `pacdiff(8)` a tool for managing `.pac*` files.

  See [Pacnew and Pacsave files](https://wiki.archlinux.org/title/Pacnew_and_Pacsave_files).

