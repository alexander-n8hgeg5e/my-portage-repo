# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{4,5,6,7,8,9,10,11} )
inherit  python-r1 git-r3 scons-utils
EGIT_REPO_URI="${CODEDIR}""/cantera"
EGIT_TAG=v${PV}
DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="blas_lapack_libs"

DEPEND="dev-python/3to2"
RDEPEND="${DEPEND}"
src_configure() {
        MYSCONS=(
        blas_lapack_libs=$()
		prefix=${ED}usr
        )
}
src_compile() {
        escons build "${MYSCONS[@]}"
}
src_install() {
	escons install "${MYSCONS[@]}"

}
