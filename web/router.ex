defmodule OpenFootyBase.Router do
  use OpenFootyBase.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.Deserializer
  end

  scope "/", OpenFootyBase do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/upload_fixture", UploadFixtureController, :index
    post "/upload_fixture", UploadFixtureController, :create
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", OpenFootyBase do
    pipe_through :api

    resources "/teams", TeamController, except: [:new, :edit]

    resources "/grounds", GroundController, except: [:new, :edit]

    resources "/seasons", SeasonController, except: [:new, :edit]

    resources "/rounds", RoundController, except: [:new, :edit]

    resources "/matches", MatchController, except: [:new, :edit]
  end
end
