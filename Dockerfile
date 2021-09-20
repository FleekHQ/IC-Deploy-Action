# FROM node:16-alpine3.11
FROM node:16

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:$PATH"

USER node

COPY dfx-install.sh /home/dfx-install.sh
COPY entrypoint.sh /home/node/entrypoint.sh

USER root

# RUN apk add --update curl
RUN apt-get update

RUN apt-get install -y curl

RUN apt-get install -y build-essential

RUN apt-get install -y libc6-dev

# RUN apt-get install -y software-properties-common

# RUN apt-get install -y g++ libgtk-3-dev libfreetype6-dev libx11-dev libxinerama-dev libxrandr-dev libxcursor-dev mesa-common-dev libasound2-dev freeglut3-dev libxcomposite-dev libcurl4-openssl-dev

# RUN add-apt-repository -r ppa:webkit-team/ppa && apt-get install -y libwebkit2gtk-4.0-37 libwebkit2gtk-4.0-dev

RUN ["chmod", "+x", "/home/dfx-install.sh"]

RUN ["sh", "-m", "/home/dfx-install.sh"]

RUN ["chmod", "+x", "/home/node/entrypoint.sh"]

ENTRYPOINT ["/home/node/entrypoint.sh"]