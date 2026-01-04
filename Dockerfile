# Base stage
FROM node:20-alpine AS base

ARG N8N_VERSION=2.1.5

USER root

RUN apk add --update graphicsmagick tzdata git tini su-exec

RUN apk add --no-cache \
    python3 \
    build-base \
    ca-certificates \
    && apk del build-base \
    && npm install -g full-icu n8n@${N8N_VERSION} \
    && rm -rf /root /tmp/* /var/cache/apk/*

RUN apk --no-cache add --virtual fonts msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f && \
    apk del fonts && \
    find  /usr/share/fonts/truetype/msttcorefonts/ -type l -exec unlink {} \; \
    && rm -rf /root /tmp/* /var/cache/apk/* && mkdir /root


# Build stage
FROM base AS build

ARG FOLDER=/app

COPY --chown=1000:1000 . /app

WORKDIR ${FOLDER}

USER 1000:1000

RUN npm install && \
    npm run build && \
    chmod +x ./docker-entrypoint.sh


# Production stage   
FROM base AS production

ARG FOLDER=/app

WORKDIR ${FOLDER}

COPY --from=build ${FOLDER}/dist ./dist

COPY --from=build ${FOLDER}/docker-entrypoint.sh ./docker-entrypoint.sh

# Copy custom files to ~/.n8n/custom/
RUN mkdir -p ~/.n8n/custom && \
    cp -rf ./dist/nodes ~/.n8n/custom && \
    cp -rf ./dist/credentials ~/.n8n/custom && \
    cp -rf ./dist/icons ~/.n8n/custom

WORKDIR /data

COPY --chmod=755 docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]

EXPOSE 5678/tcp
