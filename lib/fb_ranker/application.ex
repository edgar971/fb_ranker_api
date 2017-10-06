defmodule FbRanker.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      :poolboy.child_spec(:worker, poolboy_config()),
      # Start the Ecto repository
      supervisor(FbRanker.Repo, []),
      # Start the endpoint when the application starts
      supervisor(FbRankerWeb.Endpoint, []),
      # Start your own worker by calling: FbRanker.Worker.start_link(arg1, arg2, arg3)
      # worker(FbRanker.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FbRanker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp poolboy_config do
    [{:name, {:local, :worker}},
      {:worker_module, FbRanker.Worker},
      {:size, 100},
      {:max_overflow, 10}]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FbRankerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
