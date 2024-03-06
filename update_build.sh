#!/usr/bin/env bash

# rm -rf ./docs-old
mv  ./docs ./docs-old
mkdir ./docs
cp -r ../k9-frontend/build/* ./docs/