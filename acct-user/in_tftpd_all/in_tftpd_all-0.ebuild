EAPI=7

inherit acct-user

DESCRIPTION="tftp boot server for all nodes"
ACCT_USER_ID=30506
ACCT_USER_HOME=/node/all/boot
ACCT_USER_HOME_OWNER=root:in_tftpd_all
ACCT_USER_HOME_PERMS=2750
ACCT_USER_GROUPS=( in_tftpd_all daemon )

acct-user_add_deps
