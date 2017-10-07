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

  def handle_cast({:process_post, %{"id" => id, "created_time" => created, "message" => message}, page}, state) do
    Process.sleep(@sleep)

    reactions = FbRanker.FacebookAPI.post_reaction_count(id)
    shares = FbRanker.FacebookAPI.post_shares_count(id)
    comments = FbRanker.FacebookAPI.post_comments_count(id)
    %{fb_id: id, likes: reactions, shares: shares, comments: comments, message: message, created_time: created}
    |> FbRanker.Facebook.update_or_create_post(page, id)

    {:noreply, state}
  end

  def handle_cast({:process_page, %{page_id: id} = page}, state) do
    Process.sleep(@sleep)

    FbRanker.FacebookAPI.page_feed_this_week(id)
    |> Enum.each(&FbRanker.process_post(&1, page))

    {:noreply, state}
  end


end