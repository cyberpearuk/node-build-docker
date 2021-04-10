#!/bin/bash
set -e

load-env-npmrc > ~/.npmrc

exec "$@"