# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Python implementation for microcontrollers"
HOMEPAGE="https://github.com/micropython/micropython"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/micropython-${PV}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE="test"

DEPEND="
	virtual/libffi
	virtual/pkgconfig"
BDEPEND="xtensa-toolchain"

src_compile() {
	cd ports/esp32 || die
    export
	# 1) don't die on compiler warnings
	# 2) remove /usr/local prefix references in favour of /usr
	#sed -i \
	#	-e 's#-Werror##g;' \
	#	-e 's#\/usr\/local#\/usr#g;' \
	#	Makefile || die
	emake
}
