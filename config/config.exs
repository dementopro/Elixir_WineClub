# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

#config :mwcweb,
#  ecto_repos: [Mwcweb.Repo]

# Configures the endpoint
config :mwcweb, MwcwebWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: MwcwebWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Mwcweb.PubSub,
  live_view: [signing_salt: "oTMiVvhe"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :mwcweb, Mwcweb.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# SCOTT CMS Tesla
config :tesla, adapter: Tesla.Adapter.Hackney

# config :tailwind,
    # version: "3.0.10",
    # default: [
      # args: ~w(
      #   --config=tailwind.config.js
      #   --input=css/app.css
      #   --output=../priv/static/assets/app.css
      # ),
      # cd: Path.expand("../assets", __DIR__)
    # ]

config :tailwind,
  version: "3.1.6",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# scott airtable keys
config :mwcweb, Services.Airtable,
  api_key: "keyN7kPZVO7gOoIS4",
  base_id: "appOZTBWdbJGznxcU",
  api_url: "https://api.airtable.com/v0/"

  config :mwcweb, Mwcweb.AirtableRepo, adapter: Mwcweb.AirtableRepo.Http

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
IO.puts(:stdio,"SCOTT: #{config_env()}.exs")
import_config "#{config_env()}.exs"
