# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7


PYTHON_COMPAT=( python3_6 )
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
inherit git-r3
#inherit git-r3 distutils-r1

DESCRIPTION="a key event proxy to use one keyboard/mouse for multiple x-servers"
HOMEPAGE="${MYGITHUB_URIBASE}${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/python-xlib
"

src_install(){
	dobin keyev
	dobin mouseev
}

