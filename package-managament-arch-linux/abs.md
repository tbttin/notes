# Documents

In these orders.

## Articles

- The [Arch build
  system](https://wiki.archlinux.org/title/Arch_build_system) is a
  collection of tools for compiling source into installable
  `.pkg.tar.zst` packages.

  + **Build** source files refers to a `PKGBUILD` and others such as
    keys.

- [Arch User
  Repository](https://wiki.archlinux.org/title/Arch_User_Repository)

- [Creating
  packages](https://wiki.archlinux.org/title/Creating_packages)

  + The binary files to install.

  + `.PKGINFO`: contains all the metadata needed by pacman to deal with
    packages, dependencies, etc.

  + `.BUILDINFO`: contains information needed for reproducible builds.
    See BUILDINFO(5).

  + `.MTREE`: contains hashes and timestamps of the files, which are
    included in the local database so that pacman can verify the
    integrity of the package.

  + `.INSTALL`: an optional file used to execute commands after the
    install/upgrade/remove stage. (This file is present only if
    specified in the PKGBUILD.)

  + `.Changelog`: an optional file kept by the package maintainer
    documenting the changes of the package. (It is not present in all
    packages.)

- [Arch package
  guidelines](https://wiki.archlinux.org/title/Arch_package_guidelines)

- [PKGBUILD](https://wiki.archlinux.org/title/PKGBUILD)

- [makepkg](https://wiki.archlinux.org/title/makepkg)

- [.SCRINFO](https://wiki.archlinux.org/title/.SRCINFO)

- [Patching
  packages](https://wiki.archlinux.org/title/Patching_packages)

- [Clean
  chroot](https://wiki.archlinux.org/title/DeveloperWiki:Building_in_a_clean_chroot)

## Manuals

- `makepkg(8)`

- `makepkg.conf(5)`

- `PKGBUILD(5)`

- `BUILDINFO(5)`

- See [makepkg](package-managament-arch-linux/makepkg.md)

