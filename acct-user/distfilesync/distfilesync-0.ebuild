# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for local distfile download."
ACCT_USER_ID=19788
ACCT_USER_ENFORCE_ID=1
ACCT_USER_GROUPS=( distfilesync portage )
ACCT_USER_HOME="/var/lib/distfilesync/home"
ACCT_USER_SHELL="/bin/sh"


acct-user_add_deps


src_install(){
	acct-user_src_install
	dodir var/lib/distfilesync/home/.ssh
	touch "${D}"/var/lib/distfilesync/home/.ssh/authorized_keys
}

pkg_preinst(){
	acct-user_pkg_preinst
	fowners "${ACCT_USER_ID}" /var/lib/distfilesync/home/.ssh
	fowners "${ACCT_USER_ID}" /var/lib/distfilesync/home/.ssh/authorized_keys
	fperms 2750 /var/lib/distfilesync/home
	fperms 0700 /var/lib/distfilesync/home/.ssh
	fperms 0700 /var/lib/distfilesync/home/.ssh/authorized_keys
	einfo "feed keys here like:"
	einfo "ssh root@host cat /homedir/.ssh/id_rsa.pub |"
	einfo "sudo -u distfilesync bash -c 'cat >> /var/lib/distfilesync/home/.ssh/authorized_keys'"
}
