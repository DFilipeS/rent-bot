defmodule RentBot.Application do
  @moduledoc """
  The RentBot Application Service.

  The rent_bot system business domain lives in this application.

  Exposes API to clients such as the `RentBotWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(RentBot.Repo, []),
    ], strategy: :one_for_one, name: RentBot.Supervisor)
  end
end
