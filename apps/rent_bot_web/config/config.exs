# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rent_bot_web,
  namespace: RentBotWeb,
  ecto_repos: [RentBot.Repo]

# Configures the endpoint
config :rent_bot_web, RentBotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "88mpy9+Vk60Eh6NUk1VMUWGhJ7YfXgAIekLus1hDj3ozgcEPV5JLWIvCnNftBHPt",
  render_errors: [view: RentBotWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RentBotWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :rent_bot_web, :generators,
  context_app: :rent_bot

config :rent_bot_web, RentBotWeb.Scheduler,
  jobs: [
    {"*/5 * * * *", {RentBotWeb.Tasks.CustoJusto, :import_ads, [1]}},
    {"*/5 * * * *", {RentBotWeb.Tasks.Idealista, :import_ads, [1]}},
    {"*/5 * * * *", {RentBotWeb.Tasks.Imovirtual, :import_ads, [1]}},
  ]

config :rent_bot_web, RentBotWeb.BotController,
  facebook_messenger_verify_token: "${VERIFY_TOKEN}",
  facebook_messenger_access_token: "${ACCESS_TOKEN}"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
