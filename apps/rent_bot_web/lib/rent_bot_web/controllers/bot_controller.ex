defmodule RentBotWeb.BotController do
  use RentBotWeb, :controller

  def webhook(conn, %{"hub.mode" => mode, "hub.verify_token" => token, "hub.challenge" => challenge}) do
    verify_token = Application.get_env(:rent_bot_web, RentBotWeb.BotController)[:facebook_messenger_verify_token]

    if (mode == "subscribe" and token == verify_token) do
      IO.inspect("Webhook verified")
      send_resp(conn, 200, challenge)
    else
      send_resp(conn, 403, "Unauthorized")
    end
  end

  def incoming_message(conn, %{"object" => object, "entry" => entries}) do
    if (object == "page") do
      Enum.each(entries, fn entry ->
        event = Map.get(entry, "messaging") |> Enum.at(0)
        IO.inspect(event)
        %{"message" => %{"text" => text}, "sender" => %{"id" => sender_psid}} = event
        case text do
          "pushinhas" ->
            RentBot.Subscribers.create_subscriber(%{psid: sender_psid})
            send_message(sender_psid, "You are now subscribed to my updates! :)")
          _other -> send_message(sender_psid, "new phone who dis?")
        end
      end)

      send_resp(conn, 200, "EVENT_RECEIVED")
    else
      send_resp(conn, 404, "NOT_FOUND")
    end
  end

  def send_message(psid, message) do
    url = "https://graph.facebook.com/v2.6/me/messages?access_token=#{Application.get_env(:rent_bot_web, RentBotWeb.BotController)[:facebook_messenger_access_token]}"
    body = %{recipient: %{id: psid}, message: %{text: message}}
    headers = [{"Content-type", "application/json"}]
    HTTPoison.post(url, Poison.encode!(body), headers)
  end

  def send_card(psid, entry) do
    url = "https://graph.facebook.com/v2.6/me/messages?access_token=#{Application.get_env(:rent_bot_web, RentBotWeb.BotController)[:facebook_messenger_access_token]}"
    body = %{
      recipient: %{id: psid},
      message: %{
        attachment: %{
          type: "template",
          payload: %{
            template_type: "generic",
            elements: [
              %{
                title: entry.title,
                image_url: entry.image,
                subtitle: entry.price,
                default_action: %{
                  type: "web_url",
                  url: entry.url,
                  messenger_extensions: false,
                  webview_height_ratio: "full"
                }
              }
            ]
          }
        }
      }
    }
    headers = [{"Content-type", "application/json"}]
    HTTPoison.post(url, Poison.encode!(body), headers)
  end
end
