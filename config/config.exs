# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :coursemology,
  ecto_repos: [Coursemology.Repo]

# Use a different migration table from rails
config :coursemology, Coursemology.Repo, migration_source: "schema_migrations_ecto"

# Configures the endpoint
config :coursemology, Coursemology.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kmDfXE0Y8DLqtJRBizKBoSm1F4yt5mxC0PZYGbSx2jnea9tLFm6sZlqUgMhofHbF",
  render_errors: [view: Coursemology.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Coursemology.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use slim as the template engine
config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
