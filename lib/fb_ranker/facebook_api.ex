defmodule FbRanker.FacebookAPI do
  @moduledoc """
  Facebook API module.
  """

  @default_options [limit: 40]
  @access_token Application.get_env(:fb_ranker, :facebook_access_token)

  @doc """
  Does a Facebook Page search

      FbRanker.FacebookAPI.search("apple")
  """
  def search(query) do
    options = Enum.concat([access_token: @access_token, type: "page", q: query], @default_options);
    case Facebook.Graph.get("search", options) do
      {:json, %{"data" => data}} -> data
    end
  end

  @doc """
  Get the pages info

      FbRanker.FacebookAPI.page("apple")
  """
  def page(page_id) do
    fields = "about,category,name,fan_count"
    case Facebook.page(page_id, @access_token, fields) do
      {:json, page} -> page
    end
  end


  @doc """
  Get the page posts for the current week

      FbRanker.FacebookAPI.page_feed_this_week("apple")
  """
  def page_feed_this_week(page_id) do
    from = Timex.beginning_of_week(Timex.now) |> Timex.to_unix
    to = Timex.end_of_week(Timex.now) |> Timex.to_unix
    url = "#{page_id}/posts"
    case Facebook.Graph.get(url,[access_token: @access_token, since: from, until: to, limit: 25, fields: "type,message,created_time"]) do
      {:json, %{"data" => data}} -> data
      _ -> []
    end
  end

  @doc """
  Get's the number of total post reactions

      FbRanker.FacebookAPI.post_reaction_count
  """
  def post_reaction_count(post_id) do
    url = "#{post_id}/reactions"
    case Facebook.Graph.get(url, [access_token: @access_token, limit: 1, summary: true]) do
      {:json, %{"summary" => %{"total_count" => count}}} -> count
      _ -> 0
    end
  end

  @doc """
  Get's the number of total post comments

      FbRanker.FacebookAPI.post_comments_count("105778816037_10156744699401038")
  """
  def post_comments_count(post_id) do
    url = "#{post_id}/comments"
    case Facebook.Graph.get(url, [access_token: @access_token, limit: 1, summary: true]) do
      {:json, %{"summary" => %{"total_count" => count}}} -> count
      _ -> 0
    end
  end

  @doc """
  Get's the number of total post shares

      FbRanker.FacebookAPI.post_shares_count("105778816037_10156744699401038")
  """
  def post_shares_count(post_id) do
    url = "#{post_id}"
    case Facebook.Graph.get(url, [access_token: @access_token, limit: 1, fields: ["shares"]]) do
      {:json, %{"shares" => %{"count" => count}}} -> count
      _ -> 0
    end
  end


end
