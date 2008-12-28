# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/hugin/hugin-0.7.0.ebuild,v 1.5 2008/12/02 12:57:59 chainsaw Exp $

EAPI="1"
WX_GTK_VER="2.8"

inherit cmake-utils eutils subversion wxwidgets

ESVN_REPO_URI="https://hugin.svn.sourceforge.net/svnroot/hugin/hugin/trunk"

DESCRIPTION="GUI for the creation & processing of panoramic images"
HOMEPAGE="http://hugin.sf.net"
SRC_URI=""

LICENSE="GPL-2 SIFT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+sift"

DEPEND="
	app-arch/zip
	>=dev-libs/boost-1.30.0
	>=media-gfx/enblend-3.0_p20080807
	media-gfx/exiv2
	media-libs/jpeg
	media-libs/libpano13
	media-libs/libpng
	media-libs/openexr
	media-libs/tiff
	sys-libs/zlib
	x11-libs/wxGTK:2.8
	sift? ( media-gfx/autopano-sift-C )"

DOCS="AUTHORS README TODO"

pkg_setup() {
	if ! built_with_use --missing true dev-libs/boost threads ; then
		local msg="Build dev-libs/boost with USE=threads"
		eerror "$msg"
		die "$msg"
	fi
	wxwidgets_pkg_setup
}

src_unpack() {
	subversion_src_unpack

	cd "${S}"
	echo ${ESVN_WC_REVISION} >rev.txt
}
