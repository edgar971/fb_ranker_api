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
    Facebook.Graph.get(url,[access_token: @access_token, since: from, until: to])
  end




end
