# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )

inherit git-r3 distutils-r1

DESCRIPTION="Statistic submission client for Goose (anser.gentoo.org)"
HOMEPAGE="https://github.com/mgorny/gander/"
EGIT_REPO_URI="${CODEDIR}/${PN} ${MYGITHUB_URIBASE}${PN}.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~riscv ~x86"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	sys-apps/portage[${PYTHON_USEDEP}]
"

BDEPEND="test? ( dev-python/responses[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	# Portage exports random configuration options *overriding* its own
	# behavior into the build environment.
	env -u PORTAGE_REPOSITORIES pytest -vv || die "Tests fail with ${EPYTHON}"
}
