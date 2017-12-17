# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :snappy,
  ecto_repos: [Snappy.Repo]

# Configures the endpoint
config :snappy, SnappyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "R+01Id6Gye0cnltA+X1U6sY1VyZvswvEGqoHo2E4dqh9yaqWWqX6THXie6R37fIA",
  render_errors: [view: SnappyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Snappy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
