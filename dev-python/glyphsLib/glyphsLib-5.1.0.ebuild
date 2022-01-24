# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7


PYTHON_COMPAT=( python3_{6,7,8,9,10} )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://files.pythonhosted.org/packages/24/12/c8f445f93e9bf69d54b8efde187f899de887182f23ced0db34dd89406df9/glyphsLib-5.1.0.zip"

SHA256SUM="5ba2d9bd0db4c84426f10e66ad6879e20450e8d46553451965ba4817393e9ae8"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/wheel
	dev-python/setuptools_scm
"

#   >=dev-python/fonttools-3.24.0[ufo,unicode]
#	importlib_resources; python_version < '3.7'

RDEPEND="
	>=dev-python/ufoLib2-0.5.0
	dev-python/importlib_resources
	>=dev-python/fonttools-3.24.0
"
