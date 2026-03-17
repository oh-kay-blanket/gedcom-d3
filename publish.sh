#!/usr/bin/env bash
set -euo pipefail

# Publish a new version of gedcom-d3 to NPM
# Usage: ./publish.sh [major|minor|patch]
# Default: patch

VERSION_TYPE="${1:-patch}"

if [[ "$VERSION_TYPE" != "major" && "$VERSION_TYPE" != "minor" && "$VERSION_TYPE" != "patch" ]]; then
  echo "Usage: ./publish.sh [major|minor|patch]"
  exit 1
fi

# Ensure working directory is clean
if [[ -n "$(git status --porcelain)" ]]; then
  echo "Error: Working directory is not clean. Commit or stash changes first."
  exit 1
fi

# Ensure we're on master
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$BRANCH" != "master" ]]; then
  echo "Error: Must be on master branch to publish. Currently on '$BRANCH'."
  exit 1
fi

# Ensure we're up to date with remote
git fetch origin master
LOCAL="$(git rev-parse master)"
REMOTE="$(git rev-parse origin/master)"
if [[ "$LOCAL" != "$REMOTE" ]]; then
  echo "Error: Local master is not up to date with origin. Pull or push first."
  exit 1
fi

# Bump version (this updates package.json and creates a git tag)
echo "Bumping $VERSION_TYPE version..."
npm version "$VERSION_TYPE" -m "v%s"

# Push commit and tag
echo "Pushing to origin..."
git push origin master --tags

# Publish to NPM
echo "Publishing to NPM..."
npm publish

NEW_VERSION="$(node -p "require('./package.json').version")"
echo "Successfully published gedcom-d3@$NEW_VERSION"
