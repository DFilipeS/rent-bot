defmodule RentBot.Repo.Migrations.CreateSubscribers do
  use Ecto.Migration

  def change do
    create table(:subscribers) do
      add :psid, :string

      timestamps()
    end

    create unique_index(:subscribers, [:psid])
  end
end
