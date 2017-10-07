defmodule FbRankerWeb.PagePostController do
  use FbRankerWeb, :controller

  alias FbRanker.Facebook

  action_fallback FbRankerWeb.FallbackController

  def index(conn, %{"page_id" => page_id}) do
    posts = Facebook.list_page_posts(page_id)
    render(conn, "index.json", posts: posts)
  end

end
