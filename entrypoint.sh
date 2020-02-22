#!/bin/bash
set -e

cd /app
if [[ "$1" = 'robot' ]]; then
    bundle exec ruby run.rb
fi
if [[ -z "$1" ]]; then
    echo "No args. ($@)"
    exit 1
fi
