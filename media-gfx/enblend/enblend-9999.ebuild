# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils cvs

ECVS_SERVER="enblend.cvs.sourceforge.net:/cvsroot/enblend"
ECVS_MODULE="enblend"

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/boost-1.31.0
	media-libs/lcms
	media-libs/glew
	media-libs/plotutils
	media-libs/tiff
	virtual/glut"

S="${WORKDIR}/${PN}"

pkg_setup() {
	# bug 202476
	if ! built_with_use media-libs/plotutils X ; then
		eerror
		eerror "media-gfx/plotutils has to be built with USE=\"X\""
		eerror
		die "emerge plotutils with USE=\"X\""
	fi

	ewarn
	ewarn "Please note: the compilation of enblend needs about 1 GB RAM (and swap)."
	ewarn
}

src_unpack() {
	cvs_src_unpack
	cd "${S}"
}

src_compile() {
	emake -f Makefile.cvs || die "emake -f Makefile.cvs failed"
	sed -i -e 's:-O3::' configure || die
	econf
	# forcing -j1 as every parallel compilation process needs about 1 GB RAM.
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
