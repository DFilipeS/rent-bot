FROM elixir:1.5

ENV MIX_ENV prod

RUN apt-get update && apt-get install -y build-essential g++ make erlang-dev

WORKDIR /opt/rentbot-build
COPY . .
RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix deps.get
RUN mix phx.digest
RUN mix release

WORKDIR /opt/rentbot-release
RUN cp /opt/rentbot-build/_build/prod/rel/rent_bot_umbrella/releases/0.1.0/rent_bot_umbrella.tar.gz .
RUN tar -xzf rent_bot_umbrella.tar.gz
RUN rm rent_bot_umbrella.tar.gz

FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssl

WORKDIR /opt/rentbot
COPY --from=0 /opt/rentbot-release/ .

ENTRYPOINT ["bin/rent_bot_umbrella", "foreground"]
