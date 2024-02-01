# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop multilib toolchain-funcs git-r3

DESCRIPTION="Small dynamic tiling window manager for X11"
HOMEPAGE="https://github.com/conformal/spectrwm"
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
		x11-misc/dmenu
		!x11-wm/scrotwm
"
DEPEND="${DEPEND}
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXtst
	x11-libs/xcb-util
"

PATCHES=(
	"${FILESDIR}/${PF}-makefile.patch"
)


src_compile() {
	tc-export CC PKG_CONFIG
	emake -C linux PREFIX="${EROOT}/usr" LIBDIR="${EROOT}/usr/$(get_libdir)"
}

src_install() {
	lib_major_version=$(grep -E 'major[=]' "${S}/lib/shlib_version" \
		| sed -E 's/major[=]//')
	lib_minor_version=$(grep -E 'minor[=]' "${S}/lib/shlib_version" \
		| sed -E 's/minor[=]//')

	lib_version="${lib_major_version}.${lib_minor_version}"

	dobin "${S}/linux/spectrwm"
	dosym spectrwm /usr/bin/scrotwm
	dolib.so "${S}/linux/libswmhack.so.${lib_version}"
	dosym "libswmhack.so.${lib_version}"         "${EPREFIX}/usr/lib64/libswmhack.so.${lib_major_version}"
	dosym "libswmhack.so.${lib_version}"          "${EPREFIX}/usr/lib64/libswmhack.so"
	insinto "/etc"
	doins  "${PN}".conf
	doman "${PN}.1"
	dodoc CHANGELOG.md
#	install -m 644 spectrwm.desktop            $(DESTDIR)$(XSESSIONSDIR)

	make_session_desktop ${PN} ${PN}

}
