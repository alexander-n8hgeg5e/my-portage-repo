EAPI=7

inherit acct-user

DESCRIPTION="user for syslog daemon"
ACCT_USER_ID=541
ACCT_USER_GROUPS=( logdaemon )

acct-user_add_deps
