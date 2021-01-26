EAPI=7

inherit acct-user

DESCRIPTION="tftp boot server for ac"
ACCT_USER_ID=30505
ACCT_USER_HOME=/node/ac/boot
ACCT_USER_HOME_OWNER=root:in_tftpd_ac
ACCT_USER_HOME_PERMS=2750
ACCT_USER_GROUPS=( in_tftpd_ac daemon )

acct-user_add_deps
