# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="user for local repos sync"
ACCT_USER_ID="47838"
ACCT_USER_GROUPS=( reposync portage )
ACCT_USER_HOME="/var/lib/reposync/home"

acct-user_add_deps

src_install(){
	acct-user_src_install
	dodir var/lib/reposync/home/.ssh
	touch "${D}"/var/lib/reposync/home/.ssh/authorized_keys
}

pkg_preinst(){
	acct-user_pkg_preinst
	fowners reposync:reposync /var/lib/reposync/home/.ssh
	fowners reposync:reposync /var/lib/reposync/home/.ssh/authorized_keys
	fperms 2750 /var/lib/reposync/home
	fperms 0700 /var/lib/reposync/home/.ssh
	fperms 0700 /var/lib/reposync/home/.ssh/authorized_keys
	einfo "feed keys here like:"
	einfo "ssh root@host cat /homedir/.ssh/id_rsa.pub |"
	einfo "sudo -u reposync bash -c 'cat >> /var/lib/reposync/home/.ssh/authorized_keys'"
}
