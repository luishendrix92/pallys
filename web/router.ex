defmodule Pallys.Router do
  use Pallys.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json", "html"]
  end

  scope "/", Pallys do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/palbot", Pallys do
    pipe_through :api

    get "/", PalbotController, :index
    get "/rank/:player", PalbotController, :rank
    get "/regions/:player", PalbotController, :regions
    get "/mains/:player", PalbotController, :mains
    # get "/champions", PalbotController, :champions
  end
end
