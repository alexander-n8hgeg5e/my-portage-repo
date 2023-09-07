# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7

LICENSE=""

EGIT_REPO_URI="${CODEDIR}/${PN} ${MYGITHUB_URIBASE}${PN}.git"
inherit git-r3 meson

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xwayland"

DEPEND="xwayland? ( >=gui-libs/wlroots-0.16.0[X] ) !xwayland? ( >=gui-libs/wlroots-0.16.0 )"
RDEPEND="${DEPEND}"


src_configure() {
	local emesonargs=( $(meson_use xwayland) )
	meson_src_configure
}
