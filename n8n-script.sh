#!/bin/sh

# Exit immediately if a command fails
set -e

echo "Building and linking custom node..."

npm run build

npm link

mkdir -p n8n-server/.n8n/custom 

cd n8n-server/.n8n/custom

npm link n8n-nodes-nasapics

echo "Custom node linked successfully!"

echo "Starting n8n server..."

n8n start





