defmodule KafkaElixirLab.AttackConsumer do
  use KafkaEx.GenConsumer
  require Logger

  alias KafkaEx.Protocol.Fetch.Message
  alias KafkaEx.Protocol.Produce.Request

  def handle_message_set(message_set, state) do
    for message <- message_set do
      confirm_message_ack(message)
    end

    {:async_commit, state}
  end

  defp confirm_message_ack(%Message{key: "scala-pub"} = message) do
    msg = %KafkaEx.Protocol.Produce.Message{key: "elixir-damage", value: message.value}
    request = %Request{topic: "interactions", partition: 0, required_acks: 1, messages: [msg]}

    Logger.debug("Published an ack with power " <> message.value <> " to interactions topic")

    KafkaEx.produce(request)
  end

  defp confirm_message_ack(%Message{key: "elixir-pub"} = message) do
    Logger.debug("I am not interested on my own messages: " <> inspect(message))
  end

  defp confirm_message_ack(%Message{key: _} = message) do
    Logger.debug("Unknown message: " <> inspect(message))
  end
end
