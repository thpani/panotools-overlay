# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

ESVN_REPO_URI="https://panotools.svn.sourceforge.net/svnroot/panotools/trunk/libpano"

DESCRIPTION="Helmut Dersch's panorama toolbox library"
HOMEPAGE="http://panotools.sf.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="java"

DEPEND="!media-libs/libpano12
	media-libs/jpeg
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	java? ( virtual/jdk )"

src_compile() {
	./bootstrap "${myconf}" || die "Bootstrap failed"

	local myconf=""
	use java && myconf="--with-java=${JAVA_HOME}"
	use java || myconf="--without-java"

	econf ${myconf} || die "Configure failed"

	emake || die "Build failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README README.linux AUTHORS NEWS doc/*.txt
}
