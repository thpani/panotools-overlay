# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils mercurial

EHG_REPO_URI="http://enblend.hg.sourceforge.net:8000/hgroot/enblend"

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="!media-libs/enblend-staging
	>=dev-libs/boost-1.31.0
	media-libs/lcms
	media-libs/glew
	media-libs/plotutils[X]
	media-libs/tiff
	virtual/glut"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	emake -f Makefile.cvs || die "emake -f Makefile.cvs failed"
	sed -i -e 's/-O3//' configure || die
	econf
}

src_compile() {
	# forcing -j1 as every parallel compilation process needs about 1 GB RAM.
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
