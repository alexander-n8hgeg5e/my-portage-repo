EAPI=7

inherit acct-user

DESCRIPTION="tftp boot server for dusteater"
ACCT_USER_ID=997
ACCT_USER_HOME=/dusteater/boot
ACCT_USER_HOME_OWNER=root:in_tftpd_dusteater
ACCT_USER_HOME_PERMS=2750
ACCT_USER_GROUPS=( in_tftpd_dusteater daemon )

acct-user_add_deps
