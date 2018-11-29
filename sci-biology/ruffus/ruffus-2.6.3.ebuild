# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_5 )

inherit distutils-r1

DESCRIPTION="Python module to support computational pipelines"
HOMEPAGE="http://www.ruffus.org.uk"
SRC_URI="https://pypi.python.org/packages/97/fe/12445c6793350ab5dbf76cb87a122b9e9aab9a9040a2801004806d985216/ruffus-2.6.3.tar.gz"
#EGIT_REPO_URI="http://code.google.com/p/ruffus"
# git@github.com:bunbun/ruffus.git

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		media-gfx/graphviz"
RDEPEND="${DEPEND}"
