# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fb_ranker,
  ecto_repos: [FbRanker.Repo]


# Generator config
# https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html#content
config :fb_ranker, :generators, context_app: :fb_ranker

# Facebook Config
config :fb_ranker, facebook_access_token: Map.fetch!(System.get_env(), "F_ACCESS_TOKEN")


# Configures the endpoint
config :fb_ranker, FbRankerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8B8C+gNCaMqhjxTvjBXVTI3yfcciKVOwNiUL8COo6rEXJert+UEfo+ZtVJ6jI73I",
  render_errors: [view: FbRankerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: FbRanker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

