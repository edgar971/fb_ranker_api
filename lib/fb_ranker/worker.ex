defmodule FbRanker.Worker do
  @moduledoc """
  Scheduler module.
  """

  @sleep 500

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:process_post, %{"id" => id} = post}, state) do
    Process.sleep(@sleep)
    # Get shares, likes, comments
    # Create post
    # Save post
    reactions = FbRanker.FacebookAPI.post_reaction_count(id)
    shares = FbRanker.FacebookAPI.post_shares_count(id)
    comments = FbRanker.FacebookAPI.post_comments_count(id)
    %{reactions: reactions, shares: shares, comments: comments}
    |> IO.inspect
    {:noreply, state}
  end

  def handle_cast({:process_page, id}, state) do
    Process.sleep(@sleep)
    FbRanker.FacebookAPI.page_feed_this_week(id)
    |> Enum.each(&FbRanker.process_post/1)
    {:noreply, state}
  end


end