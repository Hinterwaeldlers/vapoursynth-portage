# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Converts VFR video to CFR video through the use of Matroska Version 2 Timecodes"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-VFRToCFR"

inherit git-r3
EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-VFRToCFR"
EGIT_COMMIT="6c8cd2b13179e1861fcabe64dadb32b411bfeb69"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD-3"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	>=dev-util/meson-0.28.0
	virtual/pkgconfig
"

src_prepare(){
	mkdir build
	eapply_user
}

src_configure(){
	cd build
	meson \
		--prefix="${EPREFIX}/usr" \
		--buildtype=plain \
		.. || die
}

src_compile(){
	cd build
	ninja -v
}

src_install(){
	cd build
	DESTDIR="${D}" ninja install
}