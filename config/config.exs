use Mix.Config

config :pallys, Pallys.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "beZ5U7GbMhML+/sHCBVics5OWOqDX48uYSie9VHcnwgo0NvdmKetrVSjCea9QDBD",
  render_errors: [view: Pallys.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pallys.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
