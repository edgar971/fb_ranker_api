defmodule FbRankerWeb.PostView do
  use FbRankerWeb, :view
  alias FbRankerWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      message: post.message,
      story: post.story,
      story: post.page_id,
      created_time: post.created_time,
      fb_id: post.fb_id,
      shares: post.shares,
      likes: post.likes}
  end
end
