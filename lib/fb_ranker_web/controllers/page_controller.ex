defmodule FbRankerWeb.PageController do
  use FbRankerWeb, :controller

  alias FbRanker.Facebook
  alias FbRanker.Facebook.Page

  action_fallback FbRankerWeb.FallbackController

  def index(conn, _params) do
    pages = Facebook.list_pages()
    render(conn, "index.json", pages: pages)
  end

  def create(conn, %{"page" => page_params}) do
    with {:ok, %Page{} = page} <- Facebook.create_page(page_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", page_path(conn, :show, page))
      |> render("show.json", page: page)
    end
  end

  def show(conn, %{"id" => id}) do
    page = Facebook.get_page!(id)
    render(conn, "show.json", page: page)
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Facebook.get_page!(id)

    with {:ok, %Page{} = page} <- Facebook.update_page(page, page_params) do
      render(conn, "show.json", page: page)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Facebook.get_page!(id)
    with {:ok, %Page{}} <- Facebook.delete_page(page) do
      send_resp(conn, :no_content, "")
    end
  end
end
