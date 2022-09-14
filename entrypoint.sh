#!/bin/bash
set -e

rm -f /monoiroha/tmp/pids/server.pid

exec "$@"
