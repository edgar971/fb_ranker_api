defmodule FbRankerWeb.GroupPostView do
  use FbRankerWeb, :view
  alias FbRankerWeb.GroupPostView
  alias FbRankerWeb.PostView

  def render("index.json", %{pages: pages}) do
    %{data: render_many(pages, GroupPostView, "page.json")}
  end

  def render("show.json", %{group_post: page}) do
    %{data: render_one(page, GroupPostView, "page.json")}
  end

  def render("page.json", %{group_post: page}) do
    %{
      name: page.name,
      posts: render(PostView, "index.json", posts: page.posts)
    }
  end
end
