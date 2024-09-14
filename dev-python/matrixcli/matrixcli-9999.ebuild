# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11,12} )
inherit distutils-r1 git-r3

DESCRIPTION="matrix cli client with basic features"
HOMEPAGE="https://github.com/saadsolimanxyz/matrixcli"
EGIT_REPO_URI="${CODEDIR}/${PN} ${MYGITHUB_URIBASE}${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND} dev-python/matrix-python-sdk[${PYTHON_USEDEP}]"
BDEPEND=""
