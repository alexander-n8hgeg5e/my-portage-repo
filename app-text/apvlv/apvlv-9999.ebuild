# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake-utils desktop git-r3

DESCRIPTION="Alf's PDF Viewer Like Vim"
HOMEPAGE="https://naihe2010.github.com/apvlv/"

EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug djvu webkit"

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	>=app-text/poppler-0.18[cairo,xpdf-headers(+)]
	dev-libs/glib:2
	x11-libs/gtk+:3
	djvu? ( app-text/djvu:= )
	app-text/ebook-tools
	webkit? ( net-libs/webkit-gtk )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DSYSCONFDIR=${EPREFIX}/etc/${PN}
		-DDOCDIR=${EPREFIX}/usr/share/${PN}
		-DMANDIR=${EPREFIX}/usr/share/man
		-DAPVLV_WITH_HTML=OFF
		-DAPVLV_WITH_WEBKIT=$(usex webkit)
		-DAPVLV_WITH_UMD=OFF
		-DAPVLV_WITH_TXT=ON
		-DAPVLV_WITH_DJVU=$(usex djvu)
		-DAPVLV_ENABLE_DEBUG=$(usex debug)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	newicon -s 32 icons/pdf.png ${PN}.png
}
