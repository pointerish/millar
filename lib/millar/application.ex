defmodule Millar.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Millar.Router,
        options: [
          dispatch: dispatch(),
          port: 13000
        ]
      ),
      Millar.Scps.Persistance,
      Millar.Scps.Cache
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Millar.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def dispatch do
    [
      {:_,
       [
         {:_, Plug.Cowboy.Handler, {Millar.Router, []}}
       ]}
    ]
  end
end
