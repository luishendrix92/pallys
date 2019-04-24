defmodule Pallys do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Pallys.Endpoint, []),
      worker(Pallys.Hirezapi, [])
    ]

    opts = [strategy: :one_for_one, name: Pallys.Supervisor]
    Supervisor.start_link(children, opts)
  end
  
  def config_change(changed, _new, removed) do
    Pallys.Endpoint.config_change(changed, removed)
    :ok
  end
end
