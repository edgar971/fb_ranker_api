defmodule FbRankerWeb.GroupPagesController do
  @moduledoc false

  use FbRankerWeb, :controller
  alias FbRanker.Accounts
  alias FbRanker.Accounts.Group
  alias FbRanker.Repo
  alias FbRanker.Facebook
  alias FbRanker.Facebook.Page


  action_fallback FbRankerWeb.FallbackController

  def index(conn, %{"id" => id}) do
    %{pages: pages} = Accounts.get_group!(id)
            |> Repo.preload(:pages)

    render(conn, "index.json", pages: pages)
  end

  def create(conn, %{"id" => id, "page" => page_id}) do

    # insert or update the page
    case Facebook.get_page_by_fb_id(page_id) do
      %{id: id} = page -> IO.inspect(page)
      nil -> IO.inspect("not found")
    end
#
#    with {:ok, %Group{} = group} <- Accounts.create_group(group_params) do
#      conn
#      |> put_status(:created)
#      |> put_resp_header("location", group_path(conn, :show, group))
#      |> render("show.json", group: group)
#    end
  end

end
