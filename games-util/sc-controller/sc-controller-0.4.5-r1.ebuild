# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# sc-controller got a second "0.4.5" release, incorprating a few changes
# between f595328 (where the v0.4.5 tag is), and d90157e (where the
# GitHub v0.4.5 release currently is -- it pointed to the previous
# commit briefly).  This -r1 revbump signifies the second release.
#
# See: https://github.com/kozec/sc-controller/releases

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="User-mode driver and GTK3 based GUI for Steam Controller"
HOMEPAGE="https://github.com/kozec/sc-controller/"
SRC_URI="https://github.com/kozec/sc-controller/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="${PYTHON_DEPS}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pylibacl[${PYTHON_USEDEP}]
	gnome-base/librsvg:2[introspection]
	>=x11-libs/gtk+-3.22:3"
DEPEND="${RDEPEND}"
