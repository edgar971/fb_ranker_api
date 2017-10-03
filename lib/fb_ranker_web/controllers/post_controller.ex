defmodule FbRankerWeb.PostController do
  use FbRankerWeb, :controller

  alias FbRanker.Facebook
  alias FbRanker.Facebook.Post

  action_fallback FbRankerWeb.FallbackController

  def index(conn, _params) do
    posts = Facebook.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Facebook.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Facebook.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Facebook.get_post!(id)

    with {:ok, %Post{} = post} <- Facebook.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Facebook.get_post!(id)
    with {:ok, %Post{}} <- Facebook.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
