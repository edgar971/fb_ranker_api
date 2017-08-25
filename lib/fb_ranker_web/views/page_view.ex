defmodule FbRankerWeb.PageView do
  use FbRankerWeb, :view
  alias FbRankerWeb.PageView

  def render("index.json", %{pages: pages}) do
    %{data: render_many(pages, PageView, "page.json")}
  end

  def render("show.json", %{page: page}) do
    %{data: render_one(page, PageView, "page.json")}
  end

  def render("page.json", %{page: page}) do
    %{id: page.id,
      name: page.name,
      about: page.about,
      page_id: page.page_id,
      fan_count: page.fan_count}
  end
end
