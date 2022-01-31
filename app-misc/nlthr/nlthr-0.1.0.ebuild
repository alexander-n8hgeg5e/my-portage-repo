# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""


LICENSE="gpl-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"


IUSE="doc"



src_compile() {
generate.sh
}
