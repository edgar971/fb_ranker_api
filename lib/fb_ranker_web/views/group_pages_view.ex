defmodule FbRankerWeb.GroupPagesView do
  @moduledoc false

  use FbRankerWeb, :view
  alias FbRankerWeb.PageView

  def render("index.json", %{pages: pages}) do
    %{data: render_many(pages, PageView, "page.json")}
  end

  def render("created.json", _) do
    %{message: "Page was attached"}
  end

end
