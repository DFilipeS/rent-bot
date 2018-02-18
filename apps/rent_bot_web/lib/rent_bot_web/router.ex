defmodule RentBotWeb.Router do
  use RentBotWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RentBotWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", RentBotWeb do
    pipe_through :api

    get "/webhook", BotController, :webhook
    post "/webhook", BotController, :incoming_message
  end

  # Other scopes may use custom stacks.
  # scope "/api", RentBotWeb do
  #   pipe_through :api
  # end
end
