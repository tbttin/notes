# Query package information

- You can use pacman's query functions to display a list of files contained in
  the package and the dependencies it requires with:

  ```bash
    pacman --query --list --file=<package-file>
  ```

  or:

  ```bash
    pacman --query --info --file=<package-file>
  ```

  or:


  ```bash
    pacman --query --info installed-package
  ```

- Find which package holds `filename`:

  ```bash
    pacman --query --owns filename
  ```

  or:


  ```bash
    pacman --files --refresh filename
  `````

- List *modified* configuration files:

  ```bash
    pacman --query --info --info | grep ^MODIFIED | cut --fileds=2
  `````

# Cache cleaning

- Pacman stores its downloaded packages in `/var/cache/pacman/pkg`.

  You can also define how many recent versions you want to keep. To retain only
  one past version use:

  ```bash
    paccache -rk1
  ```

# Mirror list

- Ranking mirror list:

  ```bash
    curl --silent 'https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on' |
    sed --expression 's/^#Server/Server/' --expression '/^#/d' |
    rankmirrors -n 6 - > mirrorlist &
  ```

