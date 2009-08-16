# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
WX_GTK_VER="2.8"

inherit cmake-utils subversion wxwidgets versionator

ESVN_REPO_URI="https://hugin.svn.sourceforge.net/svnroot/hugin/hugin/trunk"

DESCRIPTION="GUI for the creation & processing of panoramic images"
HOMEPAGE="http://hugin.sf.net"
SRC_URI=""

LICENSE="GPL-2 SIFT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

LANGS=" bg ca cs de en_GB es fr hu it ja ko nl pl pt_BR ru sk sl sv uk zh_CN zh_TW"
IUSE="lapack +sift $(echo ${LANGS//\ /\ linguas_})"

DEPEND="app-arch/zip
	>=dev-libs/boost-1.35.0-r5
	>=media-gfx/enblend-3.0_p20080807
	media-gfx/exiv2
	media-libs/jpeg
	>=media-libs/libpano13-2.9.14
	media-libs/libpng
	media-libs/openexr
	media-libs/tiff
	sys-libs/zlib
	x11-libs/wxGTK:2.8[opengl,-odbc]
	lapack? ( virtual/lapack )
	sift? ( media-gfx/autopano-sift-C )"
RDEPEND="${DEPEND}
	media-libs/exiftool"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_prepare() {
	base_src_prepare

	# Remove faulty module and force usage of system cmake FindBoost
	rm CMakeModules/FindBoost.cmake

	echo ${ESVN_WC_REVISION} >rev.txt
}

pkg_setup() {
	DOCS="AUTHORS README TODO"
	mycmakeargs="$(cmake-utils_use_enable lapack)"
}

src_install() {
	cmake-utils_src_install

	for lang in ${LANGS} ; do
		case ${lang} in
			ca) dir=ca_ES;;
			cs) dir=cs_CZ;;
			*) dir=${lang};;
		esac
		use linguas_${lang} || rm -r "${D}"/usr/share/locale/${dir}
	done
}
