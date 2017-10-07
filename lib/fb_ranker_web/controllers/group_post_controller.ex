defmodule FbRankerWeb.GroupPostController do
  use FbRankerWeb, :controller

  alias FbRanker.Facebook
  alias FbRanker.Accounts
  alias FbRanker.Repo

  action_fallback FbRankerWeb.FallbackController

  def index(conn, %{"id" => group_id}) do
    pages = Accounts.get_group_with_pages(group_id)
    |> Map.get(:pages)
    |> Enum.map(fn (page) -> page |> Repo.preload(:posts) end)

    render(conn, "index.json", pages: pages)
  end

end
