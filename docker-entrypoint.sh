#!/bin/sh
if [ -d /opt/custom-certificates ]; then
    chmod -R 1000:1000 /opt/custom-certificates && chmod -R 755 /opt/custom-certificates
    echo "Trusting custom certificates from /opt/custom-certificates."
    export NODE_OPTIONS="--use-openssl-ca $NODE_OPTIONS"
    export SSL_CERT_DIR=/opt/custom-certificates
    c_rehash /opt/custom-certificates
fi

if [ "$#" -gt 0 ]; then
    # Got started with arguments
    exec n8n "$@"
else
    # Got started without arguments
    exec n8n
fi