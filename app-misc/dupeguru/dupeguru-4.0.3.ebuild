# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_4 )
PYTHON_REQ_USE="sqlite"

inherit eutils python-single-r1

DESCRIPTION="Find duplicate files on your system"
HOMEPAGE="https://hardcoded.net/dupeguru"
MY_P="${PN}-src-${PV}"
SRC_URI="https://download.hardcoded.net/${MY_P}.tar.gz"
S=${WORKDIR}

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/PyQt5[${PYTHON_USEDEP},gui,widgets]
	>=dev-qt/qtgui-5.5[jpeg,png,gif]
	>=dev-python/hsaudiotag3k-1.1.3[${PYTHON_USEDEP}]
	>=dev-python/send2trash-1.3.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/polib[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]"

src_compile() {
	emake PYTHON=${EPYTHON} all build/help
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
