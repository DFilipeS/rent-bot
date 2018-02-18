defmodule RentBot.SubscribersTest do
  use RentBot.DataCase

  alias RentBot.Subscribers

  describe "subscribers" do
    alias RentBot.Subscribers.Subscriber

    @valid_attrs %{psid: "some psid"}
    @update_attrs %{psid: "some updated psid"}
    @invalid_attrs %{psid: nil}

    def subscriber_fixture(attrs \\ %{}) do
      {:ok, subscriber} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Subscribers.create_subscriber()

      subscriber
    end

    test "list_subscribers/0 returns all subscribers" do
      subscriber = subscriber_fixture()
      assert Subscribers.list_subscribers() == [subscriber]
    end

    test "get_subscriber!/1 returns the subscriber with given id" do
      subscriber = subscriber_fixture()
      assert Subscribers.get_subscriber!(subscriber.id) == subscriber
    end

    test "create_subscriber/1 with valid data creates a subscriber" do
      assert {:ok, %Subscriber{} = subscriber} = Subscribers.create_subscriber(@valid_attrs)
      assert subscriber.psid == "some psid"
    end

    test "create_subscriber/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Subscribers.create_subscriber(@invalid_attrs)
    end

    test "update_subscriber/2 with valid data updates the subscriber" do
      subscriber = subscriber_fixture()
      assert {:ok, subscriber} = Subscribers.update_subscriber(subscriber, @update_attrs)
      assert %Subscriber{} = subscriber
      assert subscriber.psid == "some updated psid"
    end

    test "update_subscriber/2 with invalid data returns error changeset" do
      subscriber = subscriber_fixture()
      assert {:error, %Ecto.Changeset{}} = Subscribers.update_subscriber(subscriber, @invalid_attrs)
      assert subscriber == Subscribers.get_subscriber!(subscriber.id)
    end

    test "delete_subscriber/1 deletes the subscriber" do
      subscriber = subscriber_fixture()
      assert {:ok, %Subscriber{}} = Subscribers.delete_subscriber(subscriber)
      assert_raise Ecto.NoResultsError, fn -> Subscribers.get_subscriber!(subscriber.id) end
    end

    test "change_subscriber/1 returns a subscriber changeset" do
      subscriber = subscriber_fixture()
      assert %Ecto.Changeset{} = Subscribers.change_subscriber(subscriber)
    end
  end
end
