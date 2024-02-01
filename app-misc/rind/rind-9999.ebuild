# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8,9,10} )
inherit git-r3 eutils python-r1
DESCRIPTION="rind"
HOMEPAGE="https://github.com/alexander-n8hgeg5e/rind"
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"


src_install(){
	python_foreach_impl python_doscript rind
	python_foreach_impl python_doscript rindd
	python_foreach_impl python_doscript rindoff
	python_foreach_impl python_doscript rindv
	python_foreach_impl python_doscript ril
	python_foreach_impl python_doscript rils
}
