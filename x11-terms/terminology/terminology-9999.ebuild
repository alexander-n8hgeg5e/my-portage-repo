# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
inherit git-r3
EGIT_REPO_URI="https://git.enlightenment.org/apps/terminology.git"
SLOT=0
DESCRIPTION="Feature rich terminal emulator using the Enlightenment Foundation Libraries"
HOMEPAGE="https://www.enlightenment.org/p.php?p=about/terminology"

RDEPEND=">=dev-libs/efl-1.18"
DEPEND="${RDEPEND}
	virtual/pkgconfig"


