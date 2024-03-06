#!/usr/bin/env bash

# rm -rf ./docs-old
mkdir -p ./docs-old
mkdir -p ./docs

cp -rf ./docs/* ./docs-old/
rm -rf ./docs/*
cp -r ../k9-frontend/build/* ./docs/

echo "vesting.k9finance.com" > ./docs/CNAME
