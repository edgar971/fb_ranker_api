defmodule FbRankerWeb.Router do
  use FbRankerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FbRankerWeb do
    pipe_through :api

    get "/pages/search", PageController, :search

    # Posts
    resources "/posts", FbRankerWeb.PostController

    # Pages
    resources "/pages", PageController
    resources "/pages/:page_id/posts", PagePostController, only: [:index]

    #Groups
    resources "/groups", GroupController
    resources "/groups/:id/pages", GroupPagesController, only: [:index, :create]

  end
end
