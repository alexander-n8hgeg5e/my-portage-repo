# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{8,9,10} )
inherit distutils-r1 git-r3

EGIT_REPO_URI="${CODEDIR}/${PN} ${MYGITHUB_URIBASE}${PN}.git"
EGIT_COMMIT_DATE=$PV
EGIT_BRANCH=main

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
