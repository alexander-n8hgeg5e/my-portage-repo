# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_6 )
inherit eutils distutils-r1

DESCRIPTION="PySPH is an open source framework for Smoothed Particle Hydrodynamics (SPH) simulations."
HOMEPAGE=""
SRC_URI="https://files.pythonhosted.org/packages/2d/05/a951281a3e2371a76a6de3d18f085b0d75f7568629b93d7fa9db3beaed1c/PySPH-1.0a5.tar.gz"
S=${WORKDIR}/"PySPH-1.0a5"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/mako[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
src_unpack() {
        if [ "${A}" != "" ]; then
                unpack ${A}
        fi
}

src_prepare() {
	default
    distutils-r1_python_prepare_all
}
src_configure() {
        if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
                econf
        fi
}
src_compile() {
        if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then
                emake || die "emake failed"
        fi
}
