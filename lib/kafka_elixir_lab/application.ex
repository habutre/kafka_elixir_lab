defmodule KafkaElixirLab.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: KafkaElixirLab.Worker.start_link(arg)
      KafkaElixirLab.AttackProducer,
      supervisor(
        KafkaEx.ConsumerGroup,
        [
          KafkaElixirLab.ScalaPubConsumer,
          "elixir-lab-consumer",
          ["scala-pub"],
          [
            commit_interval: 5000,
            commit_threshold: 100,
            auto_offset_reset: :earliest,
            heartbeat_interval: 1_000
          ]
        ]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KafkaElixirLab.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
