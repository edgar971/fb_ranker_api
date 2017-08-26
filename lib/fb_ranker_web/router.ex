defmodule FbRankerWeb.Router do
  use FbRankerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FbRankerWeb do
    pipe_through :api

    get "/pages/search", PageController, :search
    resources "/pages", PageController
    resources "/groups", GroupController
    resources "/groups/:id/pages", GroupPagesController, only: [:index, :create]

  end
end
