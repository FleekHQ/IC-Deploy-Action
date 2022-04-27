# FROM node:16-alpine3.11
FROM ubuntu:focal

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:$PATH"
ENV DEBIAN_FRONTEND=noninteractive

USER node

COPY dfx-install.sh /home/dfx-install.sh
COPY entrypoint.sh /home/node/entrypoint.sh

USER root

RUN apt-get update && apt-get install -y curl \
  build-essential \
  libc6-dev \
  rsync \
  npm


RUN ["chmod", "+x", "/home/dfx-install.sh"]

RUN ["sh", "-m", "/home/dfx-install.sh"]

RUN ["chmod", "+x", "/home/node/entrypoint.sh"]

ENTRYPOINT ["/home/node/entrypoint.sh"]