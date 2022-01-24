# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9,10} pypy )

inherit git-r3 distutils-r1


DESCRIPTION="Python bindings for Bluez Bluetooth Stack"
HOMEPAGE="https://github.com/karulis/pybluez"
EGIT_REPO_URI="https://github.com/karulis/pybluez.git"
EGIT_COMMIT="b58f5bfd45d5ffa1d4315e973fde1bdd6a3e5c5b"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

RDEPEND="net-wireless/bluez"
DEPEND="${RDEPEND}
	app-arch/unzip"


python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		dodoc -r examples
		docompress -x usr/share/doc/${PF}/examples
	fi
}
