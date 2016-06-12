# Khumba's Overlay

This repository is a [Gentoo overlay](https://wiki.gentoo.org/wiki/Overlay) for
my packages.  To add this overlay via Layman, run as root:

    # layman -o https://gitlab.com/khumba/khoverlay/raw/master/repositories.xml -f -a khoverlay

Or you can clone the repository and create
`/etc/portage/repos.conf/khoverlay.conf` with the following contents:

    [khoverlay]
    location = /path/to/local/khoverlay
    auto-sync = no
