use Mix.Config

config :rent_bot, ecto_repos: [RentBot.Repo]

import_config "#{Mix.env}.exs"
