defmodule KafkaElixirLab.AttackProducer do
  use GenServer
  alias KafkaEx.Protocol.Produce.{Message, Request}
  require Logger

  def start_link(args \\ %{}) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(state) do
    schedule_shot(state)

    {:ok, state}
  end

  # -- Server Callbacks

  def handle_info(:ok, state) do
    attack = Integer.to_string(:rand.uniform(10))
    msg = %Message{key: "elixir-pub", value: attack}
    request = %Request{topic: "attacks", partition: 0, required_acks: 1, messages: [msg]}

    KafkaEx.produce(request)
    Logger.info("Published a shot with power " <> attack <> " to attacks topic")
    schedule_shot(state)

    {:noreply, state}
  end

  defp schedule_shot(_state) do
    # in 200ms
    Process.send_after(self(), :ok, 200)
  end
end
