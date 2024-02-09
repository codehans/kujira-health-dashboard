defmodule KujiraHealth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # KujiraHealth.Repo,
      # Start the Telemetry supervisor
      KujiraHealthWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: KujiraHealth.PubSub},
      # Start the Endpoint (http/https)
      KujiraHealthWeb.Endpoint,
      # Start a worker by calling: KujiraHealth.Worker.start_link(arg)
      # {KujiraHealth.Worker, arg}
      KujiraHealth.Node
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KujiraHealth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KujiraHealthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
