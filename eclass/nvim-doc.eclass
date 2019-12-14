# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#
# This eclass is used by nvim.eclass and nvim-plugin.eclass to update
# the documentation tags.  This is necessary since nvim doesn't look in
# /usr/share/nvim/nvimfiles/doc for documentation; it only uses the
# versioned directory, for example /usr/share/nvim/nvim62/doc
#
# We depend on nvim being installed, which is satisfied by either the
# DEPEND in nvim-plugin or by whatever version of nvim is being
# installed by the eclass.


update_nvim_helptags() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EROOT="${ROOT}"
	local nvimfiles nvim d s

	# This is where nvim plugins are installed
	nvimfiles="${EROOT}"/usr/share/nvim/nvimfiles

	if [[ $PN != nvim-core ]]; then
		# Find a suitable nvim binary for updating tags :helptags
		nvim=$(type -P nvim 2>/dev/null)
		if [[ -z "$nvim" ]]; then
			ewarn "No suitable nvim binary to rebuild documentation tags"
		fi
	fi

	# Make nvim not try to connect to X. See :help gui-x11-start
	# in nvim for how this evil trickery works.
	if [[ -n "${nvim}" ]] ; then
		ln -s "${nvim}" "${T}/tagnvim"
		nvim="${T}/tagnvim"
	fi

	# Install the documentation symlinks into the versioned nvim
	# directory and run :helptags
	d="${EROOT%/}/usr/share/vim/vimfiles"

		# Update tags; need a nvim binary for this
		if [[ -n "$nvim" ]]; then
			einfo "Updating documentation tags in $d"
			DISPLAY= $nvim -u NONE --noplugin -n \
				'+set nobackup nomore' \
				"+helptags $d/doc" \
				'+qa!' </dev/null &>/dev/null
		fi

	[[ -n "${nvim}" && -f "${nvim}" ]] && rm "${nvim}"
}
