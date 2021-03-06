- PKGBUILD prototypes can be found in `/usr/share/pacman`

- `makepkg` build order:

  + package download/fetch and extraction

  + `prepare()`

  + `pkgver()`

  + `build()`

- Frequently used cases and explanations:

  ```bash
  makepkg --cleanbuild --syncdeps --force --iinstall [--clean]
  ```

  + Clean `${srcdir}` (`man PKGBUILD.5`) before build.

  + Install missing dependencies.

  + Build when built package already exists.

  + Install with pacman.

  + Clean up leftover work files and directories after a successful build.

  + `--noarchive`: do not create the archive.

- Generate/update checksums:

  ```bash
  makepkg --geninteg >> PKGBUILD
  # or
  updpkgsums
  ```

