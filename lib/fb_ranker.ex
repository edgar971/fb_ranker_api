defmodule FbRanker do
  @moduledoc """
  FbRanker keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  @timeout 60000


  def process_page do
    FbRanker.Facebook.list_pages()
    |> Enum.each(&process_page/1)
  end

  def process_page(%{page_id: id} = page) do
    Task.async(fn ->
      :poolboy.transaction(:worker, fn(pid) -> GenServer.call(pid, {:process_page, id}) end, @timeout)
    end)
  end

  def process_post(%{"id" => id}) do
    Task.async(fn ->
      :poolboy.transaction(:worker, fn(pid) -> GenServer.call(pid, {:process_post, id}) end, @timeout)
    end)
  end

end
