# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python{2_7,3_{6,7,8,9,10,11}} )

inherit python-r1 git-r3

DESCRIPTION="Google tool for managing git, particularly multiple repos"
HOMEPAGE="https://gerrit.googlesource.com/git-repo"

LICENSE="Apache-2.0"

inherit python-r1

EGIT_REPO_URI="${CODEDIR}""/$PN https://github.com/alexander-n8hgeg5e/${PN}.git"
#EGIT_BRANCH='localfix'

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sh ~sparc ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=""

RDEPEND="${PYTHON_DEPS}
	!app-admin/radmind
	!dev-util/repo"

src_install() {
	python_foreach_impl python_newscript "${CODEDIR}/${PN}/${PN}" ${PN}
}

