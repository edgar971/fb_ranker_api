defmodule FbRanker do
  @moduledoc """
  FbRanker keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  @timeout 60000


  def process_pages do
    FbRanker.Facebook.list_pages()
    |> Enum.each(&process_page/1)
  end

  def process_page(%{page_id: id} = page) do
    :poolboy.transaction(:worker, fn(pid) -> GenServer.cast(pid, {:process_page, id}) end)
  end

  def process_post(post) do
    :poolboy.transaction(:worker, fn(pid) -> GenServer.cast(pid, {:process_post, post}) end)
  end

end
