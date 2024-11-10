#!/usr/bin/env bash

set -x

out_dir=$(mktemp -d)
cp Dockerfile Gemfile "$out_dir"
cd "$out_dir" || exit 1
echo "yaml-dev" > packages
docker build -t test .
docker run --rm -v "${PWD}:/srv/jekyll" -u "$(id -u):$(id -g)" test new myblog
rm -rf "$out_dir"
docker rmi test
