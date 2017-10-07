defmodule FbRankerWeb.PagePostView do
  use FbRankerWeb, :view
  alias FbRankerWeb.PagePostView
  alias FbRankerWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{page_post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

end
