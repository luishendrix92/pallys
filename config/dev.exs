use Mix.Config

config :pallys, Pallys.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :pallys, Pallys.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

config :exrez,
  dev_id: "2434",
  auth_key: "3BB8A39C64824E8ABCC5B4FEBDA968E6"

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20
