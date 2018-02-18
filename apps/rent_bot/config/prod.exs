use Mix.Config

config :rent_bot, RentBot.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: 15

# import_config "prod.secret.exs"
