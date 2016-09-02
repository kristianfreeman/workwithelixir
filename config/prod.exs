use Mix.Config

config :workwithelixir, Workwithelixir.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: System.get_env("HOST"), port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configure your database
config :workwithelixir, Workwithelixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

# Do not print debug messages in production
config :logger, level: :info

config :stripity_stripe, secret_key: System.get_env("STRIPE_KEY")

config :workwithelixir, stripe_public_key: System.get_env("STRIPE_PUBLIC_KEY")
config :workwithelixir, charge_key: System.get_env("CHARGE_KEY")
