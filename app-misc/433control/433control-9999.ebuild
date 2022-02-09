# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6

LICENSE=""

PYTHON_COMPAT=( python3_{5,6,7,8,9,10} )
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
inherit git-r3 python-r1

DESCRIPTION="control the stuff in the house "
HOMEPAGE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} \
	dev-python/pyserial[${PYTHON_USEDEP}]\
	"

src_install(){
python_foreach_impl python_doscript transmitter/rfcc
python_foreach_impl python_doscript transmitter/rf
python_foreach_impl python_doscript transmitter/ir
python_foreach_impl python_doscript transmitter/gpio
dodir /usr/share/433control
insinto /usr/share/433control
doins codes/433/remote1_btn1_off
doins codes/433/remote1_btn1_on
doins codes/433/remote1_btn2_off
doins codes/433/remote1_btn2_on
doins codes/433/remote1_btn3_off
doins codes/433/remote1_btn3_on
doins codes/433/remote1_btn4_off
doins codes/433/remote1_btn4_on
doins codes/433/remote1_btnall_off
doins codes/433/remote1_btnall_on
doins codes/433/remote2_btn1_off
doins codes/433/remote2_btn1_on
doins codes/433/remote2_btn2_off
doins codes/433/remote2_btn2_on
doins codes/433/remote2_btn3_off
doins codes/433/remote2_btn3_on
doins codes/433/remote2_btn4_off
doins codes/433/remote2_btn4_on
doins codes/433/remote2_btnall_off
doins codes/433/remote2_btnall_on
doins codes/433/remote3_btn1_on
doins codes/433/remote3_btn1_off
doins codes/433/remote3_btn2_on
doins codes/433/remote3_btn2_off
doins codes/433/remote3_btn3_on
doins codes/433/remote3_btn3_off
doins codes/433/remote3_btn4_on
doins codes/433/remote3_btn4_off
doins codes/433/remote4_btn1_on
doins codes/433/remote4_btn1_off
doins codes/433/remote4_btn2_on
doins codes/433/remote4_btn2_off
doins codes/433/remote4_btn3_on
doins codes/433/remote4_btn3_off
	}
