FROM node:14.16.0-alpine

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:$PATH"

USER node

COPY dfx-install.sh /home/dfx-install.sh
COPY entrypoint.sh /home/node/entrypoint.sh

USER root

RUN apk add --update curl

RUN ["chmod", "+x", "/home/dfx-install.sh"]

RUN ["sh", "-m", "/home/dfx-install.sh"]

RUN ["chmod", "+x", "/home/node/entrypoint.sh"]

ENTRYPOINT ["/home/node/entrypoint.sh"]