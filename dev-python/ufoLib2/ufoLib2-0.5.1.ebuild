# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7


PYTHON_COMPAT=( python3_6 )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE=""
sha256sum="1ec3c4ac95fceff91b06296ecae2afa8493519c15df97cb203123d05b01ba394"
SRC_URI="https://files.pythonhosted.org/packages/ad/3b/ed43de985161d2e0bd82e4496fdffcf2542d2399925a51b5b2faf0e1c5fc/ufoLib2-0.5.1.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#	python_requires = >=3.6
#	setup_requires =
#		setuptools_scm
#		wheel
#	install_requires =
#		attrs >= 18.2.0
#		fonttools[ufo] >= 3.34.0

DEPEND="
		dev-python/wheel
		dev-python/setuptools_scm
"
RDEPEND="
		>=dev-python/attrs-18.2.0
		>=dev-python/fonttools-3.34.0
"
