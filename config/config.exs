# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :workwithelixir,
  ecto_repos: [Workwithelixir.Repo]

# Configures the endpoint
config :workwithelixir, Workwithelixir.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9plDNfKhWZ+PN6EmKOSkpBC6RPQHqtMIukV6gF3Lh5oh9NA2xRCsCosOKh9ufsbw",
  render_errors: [view: Workwithelixir.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Workwithelixir.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Workwithelixir.User,
  repo: Workwithelixir.Repo,
  module: Workwithelixir,
  logged_out_url: "/",
  opts: [:authenticatable]
# %% End Coherence Configuration %%

config :ex_admin,
  repo: Workwithelixir.Repo,
  module: Workwithelixir,
  modules: [
    Workwithelixir.ExAdmin.Dashboard,
    Workwithelixir.ExAdmin.Job,
  ]

config :xain, :after_callback, {Phoenix.HTML, :raw}

