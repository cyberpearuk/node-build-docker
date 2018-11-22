#!/bin/bash
set -e

# Check for required variables
test -v NPM_REGISTRY || (echo "Missing NPM_REGISTRY variable" && exit 1)
test -v NPM_USER     || (echo "Missing NPM_USER variable" && exit 1)
test -v NPM_PASS  || (echo "Missing NPM_PASS variable" && exit 1)

NPM_AUTHTOKEN=$(echo -n "$NPM_USER:$NPM_PASS" | openssl base64)

cat << EOF > ~/.npmrc
registry=$NPM_REGISTRY
always-auth=true
email=$GITLAB_USER_EMAIL
_auth=$NPM_AUTHTOKEN

EOF

cat ~/.npmrc

# Print user and registry
echo "User $(npm whoami)"
echo "Registry $(npm config get registry)"
echo "Email $(npm config get email)"
echo "Auth $(npm config get _auth)"

exec "$@"