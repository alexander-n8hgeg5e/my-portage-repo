# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10} )

DISTUTILS_USE_SETUPTOOLS=pyproject.toml

inherit git-r3 distutils-r1

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} ${MYGITHUB_URIBASE}${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/logbook[${PYTHON_USEDEP}]
	dev-python/matrix-nio[${PYTHON_USEDEP}]
	dev-python/unpaddedbase64[${PYTHON_USEDEP}]
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/webcolors[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/atomicwrites[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/logbook[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
BDEPEND=""

src_prepare(){
	echo
	ls -l
	echo
	rm Makefile
	rm Dockerfile
	default
}
src_install(){
	insinto /usr/lib/weechat/scripts/python
	newins main.py matrix.py
	distutils-r1_src_install
}
