# Query package information

- You can use pacman's query functions to display a list of files contained in
  the package and the dependencies it requires with:

  ```bash
  pacman --query --list --file=<package-file>
  # or
  pacman --query --info --file=<package-file>
  # or
  pacman --query --info <installed-package>
  ```

- Find which package holds `filename`:

  ```bash
  pacman --query --owns filename
  # or
  pacman --files --refresh filename
  `````

- List *modified* configuration files:

  ```bash
  pacman --query --info --info | grep ^MODIFIED | cut --fileds=2
  `````

# Cache cleaning

- Pacman stores its downloaded packages in `/var/cache/pacman/pkg`.

- You can also define how many recent versions you want to keep. To retain only
  one past version use:

  ```bash
  paccache -rk1
  ```

# Removing unused packages (orphans)

- Recursively removing orphans and their configuration files:

    ```bash
    pacman -Qtdq | pacman -Rns -
    ```

# Mirror list

- Ranking mirror list:

  ```bash
  curl -s 'https://archlinux.org/mirrorlist/' \
          -d 'country=all' \
          -d 'protocol=https' \
          -d 'ip_version=4' \
          -d 'ip_version=6' \
          -d 'use_mirror_status=on' |
          sed -e 's/^#Server/Server/' -e '/^#/d' |
          rankmirrors -n 6 - > mirrorlist &
  ```

# Log file

- Pacman log file can be found in `/var/log/pacman.log`.

