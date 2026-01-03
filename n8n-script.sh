#!/bin/sh

echo "Watching dist/ for changes..."

npx nodemon \
  --watch /app/nodes/ \
  --watch /app/credentials/ \
  --ext ts,js,json \
  --exec "sh ./restart-n8n.sh"





