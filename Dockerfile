FROM erlang:24.0-alpine

ARG PRECOMPILED_ELIXIR="https://github.com/elixir-lang/elixir/releases/download/v1.13.3/Precompiled.zip"

RUN apk update && \
    apk add -U --no-cache \
    git build-base wget curl inotify-tools nodejs npm \
    bash unzip yarn && \
    npm install npm -g --no-progress

ENV PATH "$PATH:./node_modules/.bin"

RUN wget ${PRECOMPILED_ELIXIR} --quiet && \
    mkdir /etc/elixir && \
    unzip Precompiled.zip -d /etc/elixir && \
    rm Precompiled.zip

ENV PATH "$PATH:/etc/elixir/bin"

RUN mix local.hex --force && \
    mix local.rebar --force
