# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="xrandr clone for wlroots compositors"
HOMEPAGE="https://sr.ht/~emersion/wlr-randr/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	#EGIT_REPO_URI="https://git.sr.ht/~emersion/wlr-randr"
	EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
else
	SRC_URI="https://git.sr.ht/~emersion/wlr-randr/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

DEPEND="
	dev-libs/wayland
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_prepare() {
	default
	sed -i 's/werror=true/werror=false/' meson.build || die
}
