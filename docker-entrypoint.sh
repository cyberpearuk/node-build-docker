#!/bin/bash
set -e

echo "NPM Registry: $NPM_REGISTRY"
echo "NPM User: $NPM_USER"
echo "NPM Pass: $NPM_PASS"

# Check for required variables
test -v NPM_REGISTRY || (echo "Missing NPM_REGISTRY variable" && exit 1)
test -v NPM_USER     || (echo "Missing NPM_USER variable" && exit 1)
test -v NPM_PASS  || (echo "Missing NPM_PASS variable" && exit 1)

NPM_AUTHTOKEN=$(echo -n "$NPM_USER:$NPM_PASSWORD" | openssl base64)

cat << EOF > ~/.npmrc
registry=$NPM_REGISTRY
always-auth=true
_auth=$NPM_AUTHTOKEN
EOF

# Print user and registry
echo "User $(npm whoami)"
echo "Registry $(npm config get registry)"

exec "$@"