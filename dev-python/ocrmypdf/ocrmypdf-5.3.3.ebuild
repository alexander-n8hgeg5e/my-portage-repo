# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
#DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_5 )
inherit distutils-r1
SLOT="0"
KEYWORDS=~amd64
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
DEPEND="${RDEPEND}"

SRC_URI="https://pypi.python.org/packages/cd/14/1b22a4521f7d3d0a2f855332243592f99315aaa598a3ed958b359cf9c612/ocrmypdf-5.3.3.tar.gz"

