# Copyright 2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

# Confirmed to build:
# - 1.42.6-r2
# - 1.44.0-r1
# - 1.44.2

EAPI=8

DESCRIPTION="Patch to stop letting all logged-in users modify NM system connections"
HOMEPAGE="https://khumba.net/"
SRC_URI=""

# Keywords list pulled from net-misc/networkmanager.
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~loong ~ppc ~ppc64 ~riscv ~sparc ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""
PDEPEND=">=net-misc/networkmanager-1.42.6"

S="${WORKDIR}"

src_install() {
	insinto /etc/portage/patches/net-misc/networkmanager
	doins "${FILESDIR}/nm-1.42.6-neuter-modify-system.patch"
}

pkg_postinst() {
	elog "Ensure that net-misc/networkmanager is rebuilt after this package,"
	elog "for the patch to take effect."
}
