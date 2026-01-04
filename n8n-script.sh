#!/bin/sh

echo "Watching dist/ for changes..."

exec npx nodemon \
  --signal SIGTERM \
  --watch ./nodes/ \
  --watch ./credentials/ \
  --ext ts,js,json \
  --exec "sh ./restart-n8n.sh"





