# Khumba's Overlay

This repository is my personal [Gentoo overlay](https://wiki.gentoo.org/wiki/Overlay).
In here you'll find:

- Ebuilds for the software I maintain.

- Ebuilds for some System76 programs and drivers for support of their hardware.

- Other miscellaneous packages or fixes not in the main tree.

To add this overlay via `eselect-repository`, run:

    # eselect repository enable khoverlay
    # emerge --sync khoverlay

To add the overlay via Layman, run as root:

    # layman -a khoverlay

Or you can clone the repository and create
`/etc/portage/repos.conf/khoverlay.conf` with the following contents:

    [khoverlay]
    location = /path/to/local/khoverlay
    auto-sync = no
