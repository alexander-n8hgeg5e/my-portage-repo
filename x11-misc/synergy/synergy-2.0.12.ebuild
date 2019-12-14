# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


EGIT_REPO_URI="https://github.com/symless/synergy-core"
EGIT_BRANCH=v2-dev
EGIT_COMMIT="5957206104ac2de9adfc56dffcecb03fc9d2ac74"
#EGIT_TAG=v${PN}-${PV}-beta


inherit eutils flag-o-matic gnome2-utils cmake-utils git-r3


DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers"
HOMEPAGE="http://synergy-project.org/ https://github.com/symless/synergy-core"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ppc ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="libressl"
KEYWORDS="~amd64"

S=${WORKDIR}/${PN}"-"${PV}

COMMON_DEPEND="
	net-misc/curl
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXtst
	!libressl? ( dev-libs/openssl:= )
	libressl? ( dev-libs/libressl:= )
"
DEPEND="
	${COMMON_DEPEND}
	x11-base/xorg-proto
"
RDEPEND="
	${COMMON_DEPEND}
"

src_prepare() {
	eapply_user
	cmake-utils_src_prepare
}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install () {
	dobin ../${P}_build/bin/${PN}{c,s} ../${P}_build/bin/synergy-core

	insinto /etc
	newins doc/synergy.conf.example synergy.conf

	newman doc/${PN}c.man ${PN}c.1
	newman doc/${PN}s.man ${PN}s.1

	dodoc doc/synergy.conf.example* ChangeLog
}
