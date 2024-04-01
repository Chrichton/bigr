defmodule Bigr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BigrWeb.Telemetry,
      Bigr.Repo,
      {DNSCluster, query: Application.get_env(:bigr, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Bigr.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Bigr.Finch},
      # Start a worker by calling: Bigr.Worker.start_link(arg)
      # {Bigr.Worker, arg},
      # Start to serve requests, typically the last entry
      BigrWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bigr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BigrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
