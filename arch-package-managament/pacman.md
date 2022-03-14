- You can use pacman's query functions to display a list of files contained in the package and the dependencies it requires with:

  ```
    pacman --query --list --file=<package-file>
  ```

  Or:

  ```
    pacman --query --info --file=<package-file>
  ```

  Or:


  ```
    pacman --query --info installed-package
  ```

- Find which package holds filename:

  ```
    pacman --query --owns filename
  ```

  Or:


  ```
    pacman --files --refresh filename
  `````

- List modified config files:

  ```
    pacman --query --info --info | grep ^MODIFIED | cut --fileds=2
  `````

- Ranking mirror list:

  ```
    curl --silent 'https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on' |
    sed --expression 's/^#Server/Server/' --expression '/^#/d' |
    rankmirrors -n 6 - > mirrorlist &
  `````

- Pacman stores its downloaded packages in /var/cache/pacman/pkg
You can also define how many recent versions you want to keep. To retain only one past version use:

  ```
    paccache -rk1
  ```

