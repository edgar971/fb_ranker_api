defmodule FbRankerWeb.PagePostView do
  use FbRankerWeb, :view
  alias FbRankerWeb.PagePostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PagePostView, "post.json")}
  end

  def render("show.json", %{page_post: post}) do
    %{data: render_one(post, PagePostView, "post.json")}
  end

  def render("post.json", %{page_post: post}) do
    %{id: post.id,
      message: post.message,
      created_time: post.created_time,
      fb_id: post.fb_id,
      shares: post.shares,
      comments: post.comments,
      likes: post.likes
    }
  end
end
