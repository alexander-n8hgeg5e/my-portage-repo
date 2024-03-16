# Copyright 2019 Gentoo Authors
# Copyright 2019 Alexander Wilhelmi
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9,10,11,12} )
inherit git-r3 distutils-r1
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

DESCRIPTION="python tools"
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
