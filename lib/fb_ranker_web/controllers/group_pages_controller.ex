defmodule FbRankerWeb.GroupPagesController do
  @moduledoc false

  use FbRankerWeb, :controller
  alias FbRanker.Accounts
  alias FbRanker.Repo
  alias FbRanker.Facebook
  alias FbRanker.Accounts.Group


  action_fallback FbRankerWeb.FallbackController

  def index(conn, %{"id" => id}) do
    %{pages: pages} = Accounts.get_group!(id)
            |> Repo.preload(:pages)

    render(conn, "index.json", pages: pages)
  end

  def create(conn, %{"id" => id, "page" => page_id}) do

    group = Accounts.get_group_with_pages!(id)

    with {:ok, %Group{} = group} <- attach_group_pages(group, page_id) do
      conn
      |> put_status(:created)
      |> render("created.json")
    end

  end

  defp attach_group_pages(%{pages: pages} = group, page_id) do
    page = Facebook.get_page_by_fb_id(page_id)

    # Attach
    Ecto.Changeset.change(group)
                |> Ecto.Changeset.put_assoc(:pages, Enum.concat(pages, [page]))
                |> Repo.update
  end

end
