EAPI=7

inherit acct-user

DESCRIPTION="tftp boot server for skyscraper"
ACCT_USER_ID=853
ACCT_USER_HOME=/skyscraper/boot
ACCT_USER_HOME_OWNER=root:in_tftpd_skyscraper
ACCT_USER_HOME_PERMS=2750
ACCT_USER_GROUPS=( in_tftpd_skyscraper daemon )

acct-user_add_deps
