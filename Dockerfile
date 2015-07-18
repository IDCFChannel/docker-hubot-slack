FROM iojs:2.3
MAINTAINER Masato Shimizu <ma6ato@gmail.com>

RUN mkdir -p /app
WORKDIR /app

RUN adduser --disabled-password --gecos '' --uid 1000 docker && \
    chown -R docker:docker /app

RUN npm install -g hubot coffee-script yo generator-hubot

USER docker
RUN yes | yo hubot --defaults && \
    npm install --save hubot-slack mqtt
