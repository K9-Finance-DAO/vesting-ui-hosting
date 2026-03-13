#!/usr/bin/env bash
set -euo pipefail

# Use Node 18 (required for react-scripts/craco compatibility)
export NVM_DIR="/usr/local/share/nvm"
. "$NVM_DIR/nvm.sh"
nvm use 18

REPO_URL="git@github.com:K9-Finance-DAO/k9-vesting-frontend.git"
CLONE_DIR="/tmp/k9-vesting-frontend"
BUILD_DIR="./docs"
BACKUP_DIR="./docs-old"

# Clean up any previous clone
rm -rf "$CLONE_DIR"

# Clone the frontend repo (shallow for speed)
echo "Cloning $REPO_URL ..."
git clone --depth 1 "$REPO_URL" "$CLONE_DIR"

# Install dependencies and build
echo "Installing dependencies ..."
cd "$CLONE_DIR"
yarn install

echo "Building ..."
yarn build

cd -

# Swap in the new build
rm -rf "$BACKUP_DIR"
if [ -d "$BUILD_DIR" ]; then
  mv "$BUILD_DIR" "$BACKUP_DIR"
fi
mkdir -p "$BUILD_DIR"
cp -r "$CLONE_DIR/build/"* "$BUILD_DIR/"

# Clean up the clone
rm -rf "$CLONE_DIR"

echo "Build artifacts copied to $BUILD_DIR"
echo ""

# Stage, commit, and push
git add docs/
git commit -m "updated build"
git push

echo "Pushed to remote."
