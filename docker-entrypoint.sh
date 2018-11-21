#!/bin/bash
set -e


# Check for required variables
test -v NPM_REGISTRY
test -v NPM_USER
test -v NPM_PASSWORD

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