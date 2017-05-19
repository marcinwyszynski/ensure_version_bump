#!/usr/bin/env bash
set -e

gem build ensure_version_bump.gemspec
echo "---" > ~/.gem/credentials
echo ":rubygems_api_key: ${RUBYGEMS_API_KEY}" >> ~/.gem/credentials
chmod 600 ~/.gem/credentials
gem push --verbose $(ls *.gem)
