- PKGBUILD prototypes can be found in `/usr/share/pacman/`

- makepkg order:

  + package download/fetch and extraction
  + prepare()
  + pkgver()
  + build()

- Some makepkg use-cases and its explanations:

  ```
    makepkg --cleanbuild --syncdeps --force --iinstall [--clean]
  ```

  + Clean `${srcdir}` (man PKGBUILD.5) before build.
  + Install missing dependencies.
  + Build when built package already exists.
  + Install with pacman.
  + Clean up leftover work files and directories after a successful build.

- Generate/update checksums:
  
  ```
    makepkg --geninteg >> PKGBUILD
  ```

  Or:

  ```
    updpkgsums
  ```

