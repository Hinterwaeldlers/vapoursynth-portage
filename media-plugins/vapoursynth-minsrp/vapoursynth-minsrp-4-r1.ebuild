# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

DESCRIPTION="simple blurring/sharpening filter for vaporsynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=173328"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IFeelBloated/minsrp.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/IFeelBloated/minsrp/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}/build/unix"

src_prepare() {
	cd "${WORKDIR}/${P}"
	epatch "${FILESDIR}/${P}-memalign.patch"
	cd ${S}
	autotools-utils_src_prepare
}

src_configure() {
	autotools-utils_src_configure --libdir="/usr/$(get_libdir)/vapoursynth/"
}

src_install() {
	use doc && DOCS=( "${WORKDIR}/${P}/README.md" )
	autotools-utils_src_install
}
