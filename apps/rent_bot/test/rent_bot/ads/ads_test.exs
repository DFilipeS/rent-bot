defmodule RentBot.AdsTest do
  use RentBot.DataCase

  alias RentBot.Ads

  describe "ads" do
    alias RentBot.Ads.Ad

    @valid_attrs %{price: "some price", provider: "some provider", title: "some title", url: "some url"}
    @update_attrs %{price: "some updated price", provider: "some updated provider", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{price: nil, provider: nil, title: nil, url: nil}

    def ad_fixture(attrs \\ %{}) do
      {:ok, ad} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ads.create_ad()

      ad
    end

    test "list_ads/0 returns all ads" do
      ad = ad_fixture()
      assert Ads.list_ads() == [ad]
    end

    test "get_ad!/1 returns the ad with given id" do
      ad = ad_fixture()
      assert Ads.get_ad!(ad.id) == ad
    end

    test "create_ad/1 with valid data creates a ad" do
      assert {:ok, %Ad{} = ad} = Ads.create_ad(@valid_attrs)
      assert ad.price == "some price"
      assert ad.provider == "some provider"
      assert ad.title == "some title"
      assert ad.url == "some url"
    end

    test "create_ad/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ads.create_ad(@invalid_attrs)
    end

    test "update_ad/2 with valid data updates the ad" do
      ad = ad_fixture()
      assert {:ok, ad} = Ads.update_ad(ad, @update_attrs)
      assert %Ad{} = ad
      assert ad.price == "some updated price"
      assert ad.provider == "some updated provider"
      assert ad.title == "some updated title"
      assert ad.url == "some updated url"
    end

    test "update_ad/2 with invalid data returns error changeset" do
      ad = ad_fixture()
      assert {:error, %Ecto.Changeset{}} = Ads.update_ad(ad, @invalid_attrs)
      assert ad == Ads.get_ad!(ad.id)
    end

    test "delete_ad/1 deletes the ad" do
      ad = ad_fixture()
      assert {:ok, %Ad{}} = Ads.delete_ad(ad)
      assert_raise Ecto.NoResultsError, fn -> Ads.get_ad!(ad.id) end
    end

    test "change_ad/1 returns a ad changeset" do
      ad = ad_fixture()
      assert %Ecto.Changeset{} = Ads.change_ad(ad)
    end
  end
end
