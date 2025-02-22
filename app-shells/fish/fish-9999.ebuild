# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit git-r3


DESCRIPTION="fish is the Friendly Interactive SHell"
HOMEPAGE="http://fishshell.com/"
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
EGIT_COMMIT="4939466f03915c247890d4875e90d522f3df8fe0"

LICENSE="GPL-2"
SLOT="0"
[[ "${PV}" = *_* ]] || \
#KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="nls test"

RDEPEND="
	>=dev-libs/libpcre2-10.21[pcre32]
	sys-libs/ncurses:0=
"
DEPEND="
	${RDEPEND}
	sys-devel/bc
	nls? ( sys-devel/gettext )
	test? ( dev-tcltk/expect )
"


src_configure() {
	# Set things up for fish to be a default shell.
	# It has to be in /bin in case /usr is unavailable.
	# Also, all of its utilities have to be in /bin.
    autoreconf --no-recursive #if building from Git
	econf \
		--bindir="${EPREFIX}"/bin \
		--without-included-pcre2 \
		$(use_with nls gettext)
}

src_compile() {
	emake V=1
}

src_install() {
	emake DESTDIR="${D}" V=1 install
}

src_test() {
	emake V=1 test
}

pkg_postinst() {
	elog "fish is now installed on your system."
	elog "To run fish, type 'fish' in your terminal."
	elog
	elog "It is advised not to set fish as a default login shell."
	elog "see bug #545830 for more details."
	elog "Executing fish using ~/.bashrc is an alternative"
	elog "see https://wiki.gentoo.org/wiki/Fish#Caveats for details"
	elog
	elog "To set your colors, run 'fish_config'"
	elog "To scan your man pages for completions, run 'fish_update_completions'"
	elog "To autocomplete command suggestions press Ctrl + F or right arrow key."
	elog
	elog "Please add a \"BROWSER\" variable to ${PN}'s environment pointing to the"
	elog "browser of your choice to get acces to ${PN}'s help system:"
	elog "  BROWSER=\"/usr/bin/firefox\""
	elog
	elog "In order to get lzma and xz support for man-page completion please"
	elog "emerge one of the following packages:"
	elog "  dev-python/backports-lzma"
	elog "  >=dev-lang/python-3.3"
	elog
	elog "If you have issues with cut'n'paste in X-terminals, install the"
	elog "x11-misc/xsel package."
	elog
	elog "Have fun!"
}
