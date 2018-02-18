defmodule RentBot.Subscribers.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentBot.Subscribers.Subscriber


  schema "subscribers" do
    field :psid, :string

    timestamps()
  end

  @doc false
  def changeset(%Subscriber{} = subscriber, attrs) do
    subscriber
    |> cast(attrs, [:psid])
    |> validate_required([:psid])
    |> unique_constraint(:psid)
  end
end
