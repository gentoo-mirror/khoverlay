# Copyright 2021-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

# The source tarball has been repacked in order to be DFSG-compliant.  The
# majority of sound effects this game uses come from the Ultimate Sound FX
# Bundle by Sidearm Studios, whose licensing is unclear.  Sound files not
# directly attributable to other sources have been removed from the source
# package.
#
# Additionally, the bundled Windows build of the LÖVE game engine is unnecessary
# and has been removed, which saves 4MiB packed (11MiB unpacked) compared to the
# original tarball.
#
# Removed files:
#   assets/sounds/{A,Bl,Bo,Bu,C,D,E,F,G,H,Ki,M,P,R,S,Th,U,W}*.ogg
#   engines/love/*

EAPI=8

# At least 5.2 is required due to use of 'goto'.
LUA_COMPAT=( lua5-{2..3} luajit )

inherit lua-single xdg

DESCRIPTION="Arcade shooter where you control a snake of heroes"
HOMEPAGE="https://store.steampowered.com/app/915310/SNKRX/"
SRC_URI="https://apt.khumba.net/pool/main/s/snkrx/snkrx_0~pre20220611~dfsg.orig.tar.gz
	https://apt.khumba.net/pool/main/s/snkrx/snkrx_0~pre20220611~dfsg-0kh12.1.debian.tar.xz
"

LICENSE="MIT CC-BY-SA-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

REQUIRED_USE="${LUA_REQUIRED_USE}"
DEPEND=""
RDEPEND="${DEPEND}
	${LUA_DEPS}
	games-engines/love:0[${LUA_SINGLE_USEDEP}]
"

S="${WORKDIR}/${PN}-${PV/_/\~}~dfsg"

PATCHES=(
	"${FILESDIR}/${PN}-0_pre20210726-remove-steam.patch"
	"${FILESDIR}/${PN}-0_pre20220611-remove-sounds.patch"
)

DOCS=(
	README.md
	LICENSE
	devlog.md
	todo
)

src_prepare() {
	# Remove bundled love, we add our own :).
	# (For repacked sources, these may already removed, hence -f.)
	rm -rf engine/love || die "Couldn't remove bundled engine."
	rm -rf .ctrlp .gitignore builds build.sh run.sh || die "Couldn't remove extraneous files."

	default
}

src_unpack() {
	unpack "snkrx_0~pre20220611~dfsg.orig.tar.gz"
	tar --strip-components=1 \
		-C "${WORKDIR}" \
		-xf "${DISTDIR}/snkrx_0~pre20220611~dfsg-0kh12.1.debian.tar.xz" \
		debian/null.ogg \
		debian/snkrx.6 \
		|| die "Couldn't extract files from Debian tarball."
	mv "${WORKDIR}/null.ogg" "${S}/assets/sounds" || die "Couldn't move null.ogg into place."
}

src_install() {
	einstalldocs
	rm "${DOCS[@]}" || die "Couldn't clean up docs."

	insinto "/usr/share/${PN}"
	doins -r .

	insinto "/usr/share/pixmaps"
	newins assets/images/icon.png snkrx.png

	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop"

	newbin "${FILESDIR}/${PN}-0_pre20210523-launcher.sh" snkrx

	doman "${WORKDIR}/snkrx.6"
}
