# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
inherit eutils
DESCRIPTION="pip3 pyzo install"
SLOT="0"
pkg_setup()
{
mkdir -p ${S}/usr
}


src_install() {
pip3 install --install-option="--prefix=${D}/usr" pyzo|| die "Install failed!"
}
