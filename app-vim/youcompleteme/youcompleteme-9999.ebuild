# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit git-r3 multilib python-single-r1 cmake-utils vim-plugin

EGIT_REPO_URI="https://github.com/Valloric/YouCompleteMe.git"
EGIT_COMMIT="16fd9fac9044edd0cb1c00737ec64e4b6a81418d"

DESCRIPTION="vim plugin: a code-completion engine for Vim"
HOMEPAGE="https://valloric.github.io/YouCompleteMe/"

LICENSE="GPL-3"
IUSE="+clang test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	clang? ( >=sys-devel/clang-3.3 )
	dev-libs/boost[python,threads,${PYTHON_USEDEP}]
	|| (
		app-editors/vim[python,${PYTHON_USEDEP}]
		app-editors/gvim[python,${PYTHON_USEDEP}]
	)
"
RDEPEND="
	${COMMON_DEPEND}
	dev-python/bottle[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]
	dev-python/jedi[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/waitress[${PYTHON_USEDEP}]
"
DEPEND="
	${COMMON_DEPEND}
	test? (
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/nose-1.3.0[${PYTHON_USEDEP}]
		dev-cpp/gmock
		dev-cpp/gtest
	)
"

CMAKE_IN_SOURCE_BUILD=1
CMAKE_USE_DIR=${S}/third_party/ycmd/cpp

VIM_PLUGIN_HELPFILES="${PN}"

src_prepare() {
	if ! use test; then
		sed -i '/^add_subdirectory( tests )/d' third_party/ycmd/cpp/ycm/CMakeLists.txt || die
	fi

	for third_party_module in requests pythonfutures; do    #delete them
		if [[ -d "${third_party_module}" ]]; then
			rm -r "${S}"/third_party/${third_party_module}
		fi
	done

	# Argparse is included in python 2.7
	for third_party_module in argparse bottle jedi waitress sh requests; do
		if [[ -d "${third_party_module}" ]]; then
			rm -r "${S}"/third_party/ycmd/third_party/${third_party_module}
		fi
	done

    mkdir ycm_build
    cd ycm_build
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use clang CLANG_COMPLETER)
		$(cmake-utils_use_use clang SYSTEM_LIBCLANG)
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_GMOCK=ON
		-DUSE_SYSTEM_LIBCLANG=ON
	)
	cmake-utils_src_configure
}

src_compile(){
    cmake --build . --target ycm_core
}

src_test() {
	cd "${S}/third_party/ycmd/cpp/ycm/tests" || die
	LD_LIBRARY_PATH="${EROOT}"/usr/$(get_libdir)/llvm \
		./ycm_core_tests || die

	cd "${S}"/python/ycm || die

	local dirs=( "${S}"/third_party/*/ "${S}"/third_party/ycmd/third_party/*/ )
	local -x PYTHONPATH=${PYTHONPATH}:$(IFS=:; echo "${dirs[*]}")

	nosetests --verbose || die
}

src_install() {
	dodoc *.md third_party/ycmd/*.md
	rm third_party/ycmd/{*.md,*.sh}
	find python -name *test* -exec rm -rf {} +
	egit_clean
	vim-plugin_src_install
	python_optimize "${ED}"
	#python_fix_shebang "${ED}"
}
