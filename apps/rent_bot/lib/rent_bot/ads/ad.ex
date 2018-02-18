defmodule RentBot.Ads.Ad do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentBot.Ads.Ad


  schema "ads" do
    field :price, :string
    field :provider, :string
    field :title, :string
    field :url, :string
    field :image, :string

    timestamps()
  end

  @doc false
  def changeset(%Ad{} = ad, attrs) do
    ad
    |> cast(attrs, [:provider, :title, :url, :price, :image])
    |> validate_required([:provider, :title, :url, :price])
    |> unique_constraint(:url)
  end
end
