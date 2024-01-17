# `PKGBUILD`

- `PKGBUILD` and `.install` prototypes can be found in
  `/usr/share/pacman`.

- `makepkg` supports building multiple packages from a single PKGBUILD:
  see `/PACKAGE SPLITTING`.

- See `provides ( array )` in `PKGBUILD(5)`

- When multiple types are available, the strongest checksum is to be
  preferred, the later the weaker:

  1. `b2`

  3. `sha512`

  4. `sha384`

  5. `sha256`

  6. `sha224`

  7. `sha1`

  8. `md5`

  9. `ck`.

- Update checksums:

  ```bash
  makepkg -g >> PKGBUILD
  # or (from pacman-contrib)
  updpkgsums PKGBUILD
  ```

## Options and directives

- If there have not been any upstream changes then increase `pkgrel`.

  + Include patchings, modifying configure/conpilation flags.

- `options( array )`, when `makepkg` fails, but `make` succeeds:

  + `!buildflags`, to prevent its default `CPPFLAGS`, `CFLAGS`,
    `CXXFLAGS`, and `LDFLAGS`.

  + `!makeflags`, to prevent its default `MAKEFLAGS`.

  + `!debug`, to prevent its default `DEBUG_CFLAGS`, and
    `DEBUG_CXXFLAGS`, in case the `PKGBUILD` is a debug build.

## Functions

`makepkg` build order (after the source files are
fetched/downloaded/extracted):

1. `prepare()`

   + Steps that run exactly once then put them in here.

   + Skip the extraction and this function with `--noextract`.

2. `pkgver()`

   + See [VCS package
     `pkgver()`](https://wiki.archlinux.org/title/VCS_package_guidelines#The_pkgver()_function)

   + See `pacman(8)` for more information on version comparisons.

   + See `vercmp(8)`.

3. `build()`

   + Steps that re-run after any manual edits.

4. `check()`

   Make sure the software has built correctly and works fine with its
   dependencies.

5. `package()` only this function is required, others are optional.

   + `--repackage` create package without building.

   + See `fakeroot(1)`.

- All of the packaging functions defined above are run starting inside
  `$srcdir`.

  Predefined variable `srcdir` points to the directory where makepkg
  extracts or symlinks all files in the source array.

# `makepkg`

- 3-step build cycle:

  + `./configure`

  + `make`

  + `make install`

## Common used options

```bash
makepkg --cleanbuild --syncdeps --force --iinstall
```

- `--C` clean `${srcdir}` (`man PKGBUILD(5)`) before build.

- `-s` install missing dependencies.

- `-f` build when built package already exists.

- `-i` install with pacman, or `# pacman -U pkgname.pkg.tar.zst`
  manually.

- `-c` clean up leftover work files and directories after a successful
  build.

- `--noarchive` do not create the archive.

- `--verifysource` download the file if required and perform the
  integrity checks.

- `--nobuild` when patches checking is required.

- `--holdver` can be used with VCS packages.

# Packaging

- An Arch package contains:

  + The binary files to install.

  + `.PKGINFO`: contains all the metadata needed by pacman to deal with
    packages, dependencies, etc.

  + `.BUILDINFO`: contains information needed for reproducible builds.
    See `BUILDINFO(5)`.

  + `.MTREE`: contains hashes and timestamps of the files, which are
    included in the local database so that pacman can verify the
    integrity of the package.

  + `.INSTALL`: an optional file used to execute commands after the
    install/upgrade/remove stage. (This file is present only if
    specified in the PKGBUILD.)

  + `.Changelog`: an optional file kept by the package maintainer
    documenting the changes of the package. (It is not present in all
    packages.)

- Packaging mistakes checking:

  ```bash
  namcap PKGBUILD
  # or
  namcap pkgname-pkgver.pkg.tar.zst
  ```
- Where is `$pkgname.install`? It's in
  `/var/lib/pacman/local/$pkgname/install`.

- About `PREFIX` and `--prefix`:

  + `/usr/local` only for manually built and manually installed (`make`,
    and even more manually?) packages (not tracked by `pacman`).

  + `/usr/` you know it! And why not `/bin`
    [here](https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge)

- Find binary's linked library dependency packages (installed):

  ```bash
  readelf -d $1 \
      | sed -n 's|.*Shared library: \[\([^\]*\)\]|/usr/lib/\1|p' \
      | pacman -Qqo - \
      | sort -u
  # or objdump -p
  ```

