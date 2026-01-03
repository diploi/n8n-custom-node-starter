#!/bin/sh

# Exit immediately if a command fails
set -e
N8N_PID=""

start_n8n() {
    echo "Starting n8n..."
    n8n start &
    N8N_PID=$!
    echo "n8n started (PID $N8N_PID)"
}

stop_n8n() {
    if [ -n "$N8N_PID" ]; then
        echo "Stopping n8n (PID $N8N_PID)..."
        kill -SIGINT "$N8N_PID"
        wait "$N8N_PID" || true
        echo "n8n stopped."
    fi
}

build_n8n_node() {
    echo "Building and linking custom node..."

    npm run build

    mkdir -p ./n8n-server/.n8n/custom

    cp -rf ./dist/nodes ./n8n-server/.n8n/custom

    cp -rf ./dist/credentials ./n8n-server/.n8n/custom

    echo "Custom node built successfully!"
}

# Stop n8n if running
stop_n8n

# Build and link the custom node
build_n8n_node

# Start n8n server
start_n8n

# trap to ensure n8n is stopped on script exit
trap "stop_n8n" EXIT