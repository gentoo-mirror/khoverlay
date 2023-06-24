# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Metapackage for HyperLightDrift dependencies (game not included)"
HOMEPAGE="https://www.heartmachine.com/hyper-light-drifter"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"

# Yes, the game links against both libssl.so.1.0.0 and libssl.so.1.1...
# Big THANK YOU to Gentoo for providing openssl-compat!
DEPEND=""
RDEPEND="
	dev-libs/libunistring:0/2[abi_x86_32]
	dev-libs/openssl-compat:1.0.0[abi_x86_32]
	dev-libs/openssl-compat:1.1.1[abi_x86_32]
	media-libs/glu[abi_x86_32]
	media-libs/libglvnd[abi_x86_32]
	media-libs/openal[abi_x86_32]
	net-dns/libidn2:0/2[abi_x86_32]
	net-libs/nghttp2:0/1.14[abi_x86_32]
	net-misc/curl[abi_x86_32]
	sys-devel/gcc[multilib]
	sys-libs/glibc[multilib]
	sys-libs/zlib:0/1[abi_x86_32]
	x11-libs/libX11[abi_x86_32]
	x11-libs/libXau[abi_x86_32]
	x11-libs/libXdmcp[abi_x86_32]
	x11-libs/libXext[abi_x86_32]
	x11-libs/libXrandr[abi_x86_32]
	x11-libs/libXrender[abi_x86_32]
	x11-libs/libXxf86vm[abi_x86_32]
	x11-libs/libxcb[abi_x86_32]
"
