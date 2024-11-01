# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit git-r3 qmake-utils

DESCRIPTION="navit xml file gui building"
HOMEPAGE="https://sourceforge.net/p/navitconfigurat/wiki/Wiki"
EGIT_REPO_URI="https://rbuehmann@git.code.sf.net/p/navitconfigurat/code"

SLOT="0"
src_configure() {
eqmake5
}
