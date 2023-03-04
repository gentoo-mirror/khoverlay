# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GTK_VER="$(ver_cut 1-3)"
CLASSIC_VER="$(ver_rs 3 -)"

DESCRIPTION="gtk3-classic patches for /etc/portage/patches"
HOMEPAGE="https://github.com/lah7/gtk3-classic/"
SRC_URI="https://github.com/lah7/gtk3-classic/archive/refs/tags/${CLASSIC_VER}.tar.gz -> gtk3-classic-${CLASSIC_VER}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

DEPEND=""
PDEPEND="gtk? ( ~x11-libs/gtk+-${GTK_VER} )"

S="${WORKDIR}/gtk3-classic-${CLASSIC_VER}"

src_install() {
	insinto /etc/portage/patches/x11-libs/gtk+-"${GTK_VER}"

	local index=0 file
	while read -r file; do
		: $(( ++index ))
		if [[ -z $file ]] || [[ $file = "#"* ]]; then
			continue
		fi
		newins "${S}"/"$file" gtk3-classic-"$(printf '%02d' "$index")"-"$file"
	done <"${S}"/series
}

pkg_postinst() {
	elog "Please make sure that gtk+-${GTK_VER} was merged after this package,"
	elog "to ensure that these patches are applied."
}
