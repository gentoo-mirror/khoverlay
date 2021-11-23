# Khumba's Overlay

This repository is my personal [Gentoo overlay](https://wiki.gentoo.org/wiki/Overlay).
In here you'll find:

- Ebuilds for the software I maintain.

- Ebuilds for some System76 programs and drivers for support of their hardware.
  I personally have a Darter Pro (darp6).  I am interested in having packages
  for System76's other daemons, especially `system76-firwmare` and
  `system76-power`, but I haven't figured out the Rust packaging yet.

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

This overlay's packages will only have testing keywords (`~amd64`), or no
keywords (`**`) in the case of live ebuilds.  Its packages will never be marked
stable.

All of my Gentoo machines are amd64.  These packages may or may not work on
other architectures.
