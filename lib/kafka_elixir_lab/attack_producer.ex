defmodule KafkaElixirLab.AttackProducer do
  use GenServer
  require Logger

  def start_link(args \\%{}) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(state) do
    schedule_shot(state)

    {:ok, state}
  end

  #-- Server Callbacks

  def handle_info(:ok, state) do
    # publish kafka message here
    Logger.info "TODO: publish a shot to Kafka"
    schedule_shot(state)
    
    {:noreply, state}
  end

  defp schedule_shot(state) do
    Process.send_after(self(), :ok, 200) # in 200ms
  end
end
