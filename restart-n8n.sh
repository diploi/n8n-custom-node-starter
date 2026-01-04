#!/bin/sh
set -e

echo "Building and processing custom node..."

npm run build

mkdir -p ./n8n-server/.n8n/custom

cp -rf ./dist/nodes ./n8n-server/.n8n/custom
cp -rf ./dist/credentials ./n8n-server/.n8n/custom
cp -rf ./dist/icons ./n8n-server/.n8n/custom

echo "Starting n8n..."

exec npx n8n start