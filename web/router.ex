defmodule Workwithelixir.Router do
  use Workwithelixir.Web, :router

  use Coherence.Router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, login: true
  end

  pipeline :public do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :rss do
    plug :accepts, ["xml"]
  end

  scope "/" do
    pipe_through :public
    coherence_routes :public
  end

  scope "/" do
    pipe_through :browser
    coherence_routes :private
  end

  scope "/", Workwithelixir do
    pipe_through :public
    get "/", JobController, :index

    get "/about", PageController, :about
    get "/elixirconf", PageController, :elixirconf

    get "/search", JobController, :search
    get "/jobs/new", JobController, :new
    get "/jobs/:id", JobController, :show
    get "/jobs/:id/charge", JobController, :charge
    post "/jobs/:id/accept_charge", JobController, :accept_charge
  end

  scope "/", Workwithelixir do
    pipe_through :rss
    get "/feed", PageController, :feed
  end

  scope "/", Workwithelixir do
    pipe_through :browser
    get "/authenticated", PageController, :authenticated
  end

  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes
  end

  # Other scopes may use custom stacks.
  # scope "/api", Workwithelixir do
  #   pipe_through :api
  # end
end
