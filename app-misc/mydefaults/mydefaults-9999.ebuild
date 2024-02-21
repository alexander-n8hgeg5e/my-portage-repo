# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

PYTHON_COMPAT=( python3_{6,7,8,9,10,11,12} )
inherit git-r3 python-r1

DESCRIPTION=""
HOMEPAGE=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug prefix"

DEPEND="app-misc/shortcuts[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
RDEPEND="${RDEPEND}  acct-user/distfilesync"
RDEPEND="${RDEPEND} acct-group/distfilesync"
RDEPEND="${RDEPEND}  acct-user/reposync"
RDEPEND="${RDEPEND} acct-group/reposync"
BDEPEND="sys-apps/portage[${PYTHON_USEDEP}]"

src_prepare(){
	if use debug;then
		einfo debug mode
		sed -ir 's/$(\t|[ ])*[#]sed_debug_flag_replace_line[:](.*)(\t|[ ])*$/\2' etc/fish/conf.d/15_functions.fish
	fi
	echo $( pyprep -o '' etc/resolvconf.conf || die "error pyprep" )
	default_src_prepare
}

src_install(){
## make.default
#etc_portage_profile_dir="etc/portage/profile"
#dodir "${etc_portage_profile_dir}"
#insinto "${etc_portage_profile_dir}"
#doins make.defaults

# locale
dodir "etc"
insinto "etc"
doins "etc/locale.conf"
doins "etc/locale.gen"
doins "etc/resolvconf.conf"
doins "etc/gitconfig"
doins "etc/git-mailmap"
doins "etc/tmux.conf"
doins "etc/etc-update.conf"

# etc/mirror
dodir "etc"
doins "etc/mirror"
dodir "var/gentoo-mirror"
dosym ../db/distfiles /var/gentoo-mirror/distfiles

# repos.conf
if ! use prefix ; then
	etc_portage_repos_conf_dir="etc/portage/repos.conf"
	dodir "${etc_portage_repos_conf_dir}"
	insinto "${etc_portage_repos_conf_dir}"
	doins   "${etc_portage_repos_conf_dir}/"*
fi

# binrepos.conf
if ! use prefix ; then
	etc_portage_binrepos_conf_dir="etc/portage/binrepos.conf"
	dodir "${etc_portage_binrepos_conf_dir}"
	insinto "${etc_portage_binrepos_conf_dir}"
	doins   "${etc_portage_binrepos_conf_dir}/"*
fi

# /etc/profile.d
etc_profiled_dir="etc/profile.d"
dodir "${etc_profiled_dir}"
insinto "${etc_profiled_dir}"
doins   "${etc_profiled_dir}/"*

# env.d
etc_envd_dir="etc/env.d"
dodir "${etc_envd_dir}"
insinto "${etc_envd_dir}"
doins   "${etc_envd_dir}/"*

# fish default conf
etc_fish_confd_dir="etc/fish/conf.d"
dodir "${etc_fish_confd_dir}"
insinto "${etc_fish_confd_dir}"
doins   "${etc_fish_confd_dir}/"*

# bash default conf
etc_bash_confd_dir="etc/bash/bashrc.d"
dodir "${etc_bash_confd_dir}"
insinto "${etc_bash_confd_dir}"
doins   "${etc_bash_confd_dir}/"*

# etc/vim
etc_portage_pau_dir="etc/vim"
dodir   "${etc_portage_pau_dir}"
insinto "${etc_portage_pau_dir}"
doins   "${etc_portage_pau_dir}/"*


# no more use flags here
# -> moved to my profile


# no more accept_keywords here
# -> moved to my profile


## mask
#etc_portage_mask_dir="etc/portage/package.mask"
#dodir               "${etc_portage_mask_dir}"
#insinto             "${etc_portage_mask_dir}"
#doins               "${etc_portage_mask_dir}/"*
#
# unmask
etc_portage_unmask_dir="etc/portage/package.unmask"
dodir               "${etc_portage_unmask_dir}"
insinto             "${etc_portage_unmask_dir}"
doins               "${etc_portage_unmask_dir}/"*

# license
etc_portage_license_dir="etc/portage/package.license"
dodir               "${etc_portage_license_dir}"
insinto             "${etc_portage_license_dir}"
doins               "${etc_portage_license_dir}/"*

# env
etc_portage_env_dir="etc/portage/env"
dodir               "${etc_portage_env_dir}"
insinto             "${etc_portage_env_dir}"
doins               "${etc_portage_env_dir}/"*

etc_default_dir="etc/default"
dodir   "${etc_default_dir}"
insinto "${etc_default_dir}"
doins   "${etc_default_dir}/pulse_server"

etc_confd_dir="etc/conf.d"
dodir   "${etc_confd_dir}"
insinto "${etc_confd_dir}"
doins   "${etc_confd_dir}/"*

etc_pdnsd_dir="etc/pdnsd"
dodir   "${etc_pdnsd_dir}"
insinto "${etc_pdnsd_dir}"
doins   "${etc_pdnsd_dir}/"*

etc_ssh_dir="etc/ssh"
dodir   "${etc_ssh_dir}"
insinto "${etc_ssh_dir}"
doins   "${etc_ssh_dir}/"*
}
