# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: prefix_fix.eclass
# @MAINTAINER:
# root
# @AUTHOR:
# root
# @BLURB:
# @DESCRIPTION:

fix_image_dir(){
	ewarn "buggy code tries to fix the image-dir"
	move_files=$(find "${D}" ! -type d ! -wholename "${ED}/*" -printf '%P\n')
	for f in $move_files;do
		ewarn mkdir -p $(dirname "${ED}/${f}")
		mkdir -p $(dirname "${ED}/${f}")
		ewarn mv "${D}/${f}" "${ED}/${f}"
		mv "${D}/${f}" "${ED}/${f}"
	done
	rm_dirs=$(find "${D}" -type d ! -wholename "${ED}*" -printf '%P\n'|tac)
	for f in $rm_dirs;do
		ewarn rmdir "${D}/${f}"
		rmdir "${D}/${f}"
	done
	ewarn "done with fixing image-dir."
}
