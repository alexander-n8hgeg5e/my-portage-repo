# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9,10} )

inherit eutils python-single-r1

DESCRIPTION="Future-aware personal finances management"
HOMEPAGE="https://hardcoded.net/moneyguru"
MY_P="${PN}-src-${PV}"
SRC_URI="https://download.hardcoded.net/${MY_P}.tar.gz"
S=${WORKDIR}

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/PyQt4[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/sphinx[${PYTHON_USEDEP}]"

src_configure() {
	# For pip to be installed, we need to create the env without system-site-packages
	"${EPYTHON}" -m venv "${WORKDIR}/env"
	"${WORKDIR}/env/bin/pip" install sgmllib3k polib
	# And now, we upgrade the env with system-site-packages
	"${EPYTHON}" -m venv --system-site-packages "${WORKDIR}/env"
	"${WORKDIR}/env/bin/python" configure.py
}

src_compile() {
	"${WORKDIR}/env/bin/python" build.py
	"${WORKDIR}/env/bin/python" -c "import package; package.package_arch()"
}

src_install() {
	RS="${S}/build/moneyguru-arch"
	into /
	doicon "${WORKDIR}/images/logo_big.png"
	domenu "${WORKDIR}/debian/moneyguru.desktop"
	insinto /usr/share/moneyguru
	doins -r "${RS}/*"
	fperms a+x /usr/share/moneyguru/run.py
	dosym /usr/share/moneyguru/run.py /usr/bin/moneyguru
}
