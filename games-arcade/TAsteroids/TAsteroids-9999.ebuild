# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3 qmake-utils
DESCRIPTION="TAsteroids Game"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qt3d-5.8
	>=dev-qt/qtmultimedia-5.8
	>=dev-qt/qtimageformats-5.8
	>=dev-qt/qtdeclarative-5.8
"
RDEPEND="${DEPEND}
	>=dev-qt/qtquickcontrols2-5.8
	>=dev-qt/qtquickcontrols-5.8
	>=dev-qt/qtdeclarative-5.8[localstorage]
"

src_prepare(){
	default_src_prepare
	eqmake5 tasteroids.pro
}
src_install(){
	dobin tasteroids
}
