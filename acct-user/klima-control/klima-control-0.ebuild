EAPI=7

inherit acct-user

DESCRIPTION="klima control daemon"
ACCT_USER_ID=971
ACCT_USER_HOME=/run/klima-control
ACCT_USER_HOME_OWNER=klima-control:klima-control
ACCT_USER_HOME_PERMS=2750
ACCT_USER_GROUPS=( klima-control rfcontrol )

acct-user_add_deps
