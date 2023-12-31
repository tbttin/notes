# `PKGBUILD` functions

`makepkg` build order (after the source are fetched, extracted):

1. `prepare()`

   - Steps that run exactly once then put them in here.

   - Skip the extraction and this function with `--noextract`.

2. `pkgver()`

   - See [VCS package
     `pkgver()`](https://wiki.archlinux.org/title/VCS_package_guidelines#The_pkgver()function)

   - See `pacman(8)` for more information on version comparisons.

3. `build()`

   - Steps that re-run after any manual edits.

4. `check()`

   Make sure the software has built correctly and works fine with its
   dependencies.

5. `package()` only this function is required, others are optional.

   - `--repackage` create package without building.

   - See `fakeroot(1)`.

  Then, using `namcap` to check the PKGBUILD and the package has been
  created is recommended.

# `makepkg` common used options:

```bash
makepkg --cleanbuild --syncdeps --force --iinstall [--clean]
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

- `--holdver` when using VSC sources.

# Misc

- 3-step build cycle:

  + `./configure`

  + `make`

  + `make install`

- Generate/update checksums:

  ```bash
  makepkg --geninteg >> PKGBUILD

  # or updpkgsums from pacman-contrib package
  updpkgsums PKGBUILD

  # or manually
  sha512sum $files
  ```

- Packaging mistakes checking:

  ```bash
  namcap PKGBUILD
  # or
  namcap pkgname-pkgver.pkg.tar.zst
  ```

- About `PREFIX` and `--prefix`:

  + `/usr/local` only for manually built and manually installed (`make`,
    and even more manually?) packages (not tracked by `pacman`).

- Find binary's linked library dependency packages:

  ```bash
  readelf -d $1 \
      | sed -n 's|.*Shared library: \[\([^\]*\)\]|/usr/lib/\1|p' \
      | pacman -Qqo - \
      | sort -u
  # or objdump -p
  ```

- If there have not been any upstream changes then increase `pkgrel`.

  + Include patchings?

# PKGBUILD

- PKGBUILD prototypes can be found in `/usr/share/pacman`.

- A prototype `.install` is provided at
  `/usr/share/pacman/proto.install`.

- Use `updpkgsums(8)` to in place update PKGBUILD checksums.

- See `provides` array in `PKGBUILD(5)`

- When multiple types are available, the strongest checksum is to be
  preferred: `b2` over `sha512`, `sha512` over `sha384`, `sha384` over
  `sha256`, `sha256` over `sha224`, `sha224` over `sha1`, `sha1` over
  `md5`, and `md5` over `ck`.
