defmodule FbRankerWeb.Router do
  use FbRankerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FbRankerWeb do
    pipe_through :api

    resources "/pages", PageController
    resources "/groups", GroupController
  end
end
