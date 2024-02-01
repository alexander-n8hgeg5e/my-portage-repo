# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7
#DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_6 python3_7 python3_{8,9,10,11})
inherit distutils-r1
SLOT="0"
KEYWORDS=~amd64
LICENSE=MPL-2.0
DESCRIPTION="OCRmyPDF adds an OCR text layer to scanned PDF files, allowing them to be searched or copy-pasted."
RDEPEND="${RDEPEND} \
dev-python/setuptools[${PYTHON_USEDEP}] \
>=dev-python/cffi-1.9.1[${PYTHON_USEDEP}] \
>=media-gfx/img2pdf-0.2.3[${PYTHON_USEDEP}] \
>=dev-python/PyPDF2-1.26[${PYTHON_USEDEP}] \
>=dev-python/reportlab-3.3.0[${PYTHON_USEDEP}] \
>=dev-python/pillow-4.0.0[${PYTHON_USEDEP}] \
=sci-biology/ruffus-2.6.3[${PYTHON_USEDEP}] \
"
DEPEND="${RDEPEND} \
	app-text/tesseract
	"

SRC_URI="https://files.pythonhosted.org/packages/66/2a/8161bb736bcd32e0ed21a02e9cba22de5fd6b27cf0e92141cf7457842c60/ocrmypdf-12.7.1.tar.gz"
