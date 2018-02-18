defmodule RentBot.Repo.Migrations.AddImageToAdsTable do
  use Ecto.Migration

  def change do
    alter table(:ads) do
      add :image, :text
    end
  end
end
