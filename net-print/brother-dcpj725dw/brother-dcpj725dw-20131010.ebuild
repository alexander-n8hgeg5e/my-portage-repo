# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

MODEL="${PN#*-}"
PV_LPR="3.0.1-1"
PV_CUPSWRAPPER="3.0.0-1"

DESCRIPTION="Brother printer driver for DCP-J725DW"
HOMEPAGE="http://www.brother.com/"
SRC_URI="http://download.brother.com/welcome/dlf005614/${MODEL}lpr-${PV_LPR}.i386.rpm"

LICENSE="GPL-2+ Brother-lpr no-source-code"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="metric"
RESTRICT="strip"

RDEPEND="net-print/cups"

S="${WORKDIR}/opt/brother/Printers/${MODEL}"

src_prepare() {
	if use metric; then
		sed -i "/^PaperType/s/Letter/A4/" inf/br${MODEL}rc || die
	fi
}

src_install() {
	local dest=/opt/brother/Printers/${MODEL}

	cd "${S}"/lpd || die
	exeinto ${dest}/lpd
	doexe br${MODEL}filter filter${MODEL} psconvertij2
	dosym ${dest}/lpd/filter${MODEL} \
		  /usr/libexec/cups/filter/brother_lpdwrapper_${MODEL}

	cd "${S}"/inf || die
	insinto ${dest}/inf
	doins br${MODEL}func ImagingArea paperinfij2
	doins -r lut
	insinto /etc${dest}/inf
	doins br${MODEL}rc			# config file
	dosym /etc${dest}/inf/br${MODEL}rc ${dest}/inf/br${MODEL}rc

}
