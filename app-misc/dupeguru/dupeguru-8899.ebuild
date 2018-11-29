# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
PYTHON_REQ_USE="sqlite"

inherit python-r1 git-r3

DESCRIPTION="Find duplicate files on your system"
HOMEPAGE="https://hardcoded.net/dupeguru"
EGIT_REPO_URI="${CODEDIR}""/dupeguru https://github.com/alexander-n8hgeg5e/dupeguru.git https://github.com/hsoft/dupeguru.git"
EGIT_COMMIT="45b907a529c818620acc6c2fa030d5b955f82060"


LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/PyQt5[${PYTHON_USEDEP}]
	>=dev-qt/qtgui-5.5[jpeg,png,gif]
	>=dev-python/hsaudiotag3k-1.1.3[${PYTHON_USEDEP}]
	>=dev-python/send2trash-1.3.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/polib[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]"


src_compile() {
	emake all build/help modules
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
