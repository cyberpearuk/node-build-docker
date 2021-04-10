#!/usr/bin/env bash
set -e

load-env-npmrc > ~/.npmrc

exec "$@"