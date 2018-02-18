use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rent_bot_web, RentBotWeb.Endpoint,
  http: [port: 4001],
  server: false
