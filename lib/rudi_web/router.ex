defmodule RudiWeb.Router do
  use RudiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RudiWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RudiWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/coach", PageController, :coach
    get "/me", UserController, :profile
    resources "/blog", PostController, only: [:index, :show, :new, :create, :edit, :update]
    resources "/reports", ProgressReportController, only: [:index, :show]
    resources "/prompts", PromptController, only: [:show]
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/seeds", SeedController, only: [:index, :show, :new, :create, :edit, :delete]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", RudiWeb do
  #   pipe_through :api
  # end
end
