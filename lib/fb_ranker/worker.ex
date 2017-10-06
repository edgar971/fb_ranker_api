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

  def handle_call({:process_post, id}, _from, state) do
    IO.puts "process #{inspect self()} for processing post #{id}"

    {:reply, id, state}
  end

  def handle_call({:process_page, id}, _from, state) do
    IO.puts "process #{inspect self()} for processing page #{id}"

    FbRanker.FacebookAPI.page_feed_this_week(id)
    |> Enum.each(&FbRanker.process_post/1)

    {:reply, id, state}
  end


end