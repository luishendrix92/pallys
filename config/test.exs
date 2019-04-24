use Mix.Config

config :pallys, Pallys.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn
