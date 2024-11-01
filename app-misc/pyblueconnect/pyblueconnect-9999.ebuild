# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3
DESCRIPTION="connects bluetooth devices. hardcoded mac -> patch2conf."
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-wireless/bluez \
	dev-python/dbus-python"
RDEPEND="${DEPEND}"

src_install(){
dobin pyblueconnect2room
dobin pyblueconnect2headphone
dobin bluetooth_discovery_enable
}
