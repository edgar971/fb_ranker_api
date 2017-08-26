defmodule FbRanker.FacebookAPI do
  @moduledoc """
  Facebook API module.
  """
  @default_options [limit: 40]
  @access_token Application.get_env(:fb_ranker, :facebook_access_token)

  @doc """

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

  FbRanker.Facebook.API.page("apple")
  """
  def page(page_id) do
    fields = "about,category,name,fan_count"
    case Facebook.page(page_id, @access_token, fields) do
      {:json, page} -> page
    end
  end

end
