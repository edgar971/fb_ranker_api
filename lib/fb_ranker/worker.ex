defmodule FbRanker.Worker do
  @moduledoc """
  Scheduler module.
  """

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:process_post, %{"id" => id} = post}, state) do
    FbRanker.FacebookAPI.post_reaction_count(id)
    |> IO.inspect
    {:noreply, state}
  end

  def handle_cast({:process_page, id}, state) do
    IO.inspect("Working on page #{id}")
    FbRanker.FacebookAPI.page_feed_this_week(id)
    |> Enum.each(&FbRanker.process_post/1)
    {:noreply, state}
  end


end