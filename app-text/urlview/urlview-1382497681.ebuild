# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="show menu with urls and opens in browser"
HOMEPAGE="https://github.com/sigpipe/urlview"
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/sigpipe/urlview"
EGIT_BRANCH=master
EGIT_COMMIT_DATE="${PV}"

inherit git-r3 autotools

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="slang"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="slang? ( sys-libs/slang )"

PATCHES=(
    "${FILESDIR}/${P}-fix-build-by-adding-tinfo-lib-to-configure.in.patch"
    "${FILESDIR}/${P}-fix-man-path.patch"
    "${FILESDIR}/${P}-fix-syntax-if-slang.patch"
    "${FILESDIR}/${P}-urlsize.patch"
)

src_configure(){
	rm configure
	rm Makefile.in
	rm aclocal.m4
	eautoreconf
	econf $(use_with slang)
}
src_install(){
	mv urlview.man urlview.1
	doman urlview.1
	default
}
