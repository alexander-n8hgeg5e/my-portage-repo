# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{3,5,6,7,8,9} )

inherit git-r3 distutils-r1
DESCRIPTION="clipboard app"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools_scm"
RDEPEND="${DEPEND} dev-python/pygobject[${PYTHON_USEDEP}]"
