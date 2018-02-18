use Mix.Config

# Configure your database
config :rent_bot, RentBot.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "rent_bot_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
