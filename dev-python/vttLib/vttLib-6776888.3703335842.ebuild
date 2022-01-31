# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7


PYTHON_COMPAT=( python3_{6,7,8,9,10} )
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
inherit git-r3 distutils-r1
EGIT_COMMIT="dcbc6ba2e1623949f41df53e6901eb6b525292cc"

DESCRIPTION="Font conversion lib ,does something with \"VTT,TTX,TSI*,fpgm\" stuff"
HOMEPAGE="https://github.com/daltonmaag/vttLib.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"


# left, from requirements.txt or so
# python_requires = >=3.6


DEPEND="
		>=dev-python/fonttools-3.16.0
		>=dev-python/pyparsing-2.1.5
		dev-python/ufoLib2
		dev-python/setuptools_scm
		dev-python/wheel
		test? ( dev-python/pytest )
		test? ( dev-python/ufo2ft )
"

RDEPEND="${DEPEND}"
