# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

MODEL="${PN#*-}"
PV_LPR="3.0.1-1"
PV_CUPSWRAPPER="3.0.0-1"

DESCRIPTION="Brother CUPS printer driver for DCP-J725DW"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"


LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="metric"
RESTRICT="strip"

RDEPEND="net-print/cups"
RDEPEND="${DEPEND}"

src_install() {
	local dest=/opt/brother/Printers/${MODEL}

	dosym ${dest}/lpd/filter${MODEL} \
		  /usr/libexec/cups/filter/brother_lpdwrapper_${MODEL}

	cd "${S}"/cupswrapper || die
	insinto ${dest}/cupswrapper
	cd "${S}"
	doins ppd/brother_dcpj725dw_printer_en.ppd
	dosym ${dest}/cupswrapper/brother_dcpj725dw_printer_en.ppd \
		  /usr/share/cups/model/Brother/brother_dcpj725dw_printer_en.ppd

	# The brprintconf utility is very broken and mangles the path
	# of the function list file. Therefore, don't install it.
	#exeinto ${dest}/bin
	#doexe "${WORKDIR}"/usr/bin/brprintconf_${MODEL}
}
