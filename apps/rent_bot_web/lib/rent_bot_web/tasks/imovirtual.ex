defmodule RentBotWeb.Tasks.Imovirtual do
  require Logger

  alias Crawler.Imovirtual
  alias RentBot.Ads
  alias RentBot.Subscribers
  alias RentBotWeb.BotController

  def import_ads(page \\ 1) do
    Logger.info("Checking Imovirtual for updates...")
    case Imovirtual.import(page) do
      [] ->
        :stop
      entries ->
        new_entries = process_entries(entries)

        if (length(new_entries) > 0) do
          notify_subscribers(new_entries)
          import_ads(page + 1)
        end
    end
  end

  defp process_entries(entries) do
    entries
    |> Enum.map(&insert_entry/1)
    |> Enum.filter(fn x -> x != nil end)
  end

  defp insert_entry(entry) do
    case Ads.get_ad_by_url(entry.url) do
      nil -> Ads.create_ad(entry)
      _other -> nil
    end
  end

  defp notify_subscribers(entries) do
    subscribers = Subscribers.list_subscribers()

    Enum.each(entries, fn entry ->
      Enum.each(subscribers, fn x ->
        BotController.send_card(x.psid, entry)
      end)
    end)
  end
end
