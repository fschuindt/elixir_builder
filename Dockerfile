FROM erlang:25.2.3-alpine

ARG PRECOMPILED_ELIXIR="https://github.com/elixir-lang/elixir/releases/download/v1.14.3/elixir-otp-25.zip"

RUN apk update && \
    apk add -U --no-cache \
    git build-base wget curl inotify-tools nodejs npm \
    bash unzip yarn && \
    npm install npm -g --no-progress

ENV PATH "$PATH:./node_modules/.bin"

RUN wget ${PRECOMPILED_ELIXIR} --quiet && \
    mkdir /etc/elixir && \
    unzip elixir-otp-25.zip -d /etc/elixir && \
    rm elixir-otp-25.zip

ENV PATH "$PATH:/etc/elixir/bin"

RUN mix local.hex --force && \
    mix local.rebar --force
