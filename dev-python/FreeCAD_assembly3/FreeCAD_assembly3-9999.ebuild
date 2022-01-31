# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7


PYTHON_COMPAT=( python3_{6,7,8,9,10} )
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
inherit git-r3 distutils-r1

DESCRIPTION="freecad add-on assembly3"
HOMEPAGE="https://github.com/realthunder/FreeCAD_assembly3"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/freecad"
RDEPEND="${DEPEND}"
