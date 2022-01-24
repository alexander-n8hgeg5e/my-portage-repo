# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9,10} )
inherit distutils-r1 git-r3

DESCRIPTION="python latex tools"
HOMEPAGE="https://github.com/JelteF/PyLaTeX"
EGIT_REPO_URI="${CODEDIR}/${PN} ${MYGITHUB_URIBASE}${PN}.git"
EGIT_COMMIT='483953180db945bb888af0e3cd99da2b1a417ad1'

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} dev-python/sphinx dev-python/numpy dev-python/matplotlib"
BDEPEND=""
