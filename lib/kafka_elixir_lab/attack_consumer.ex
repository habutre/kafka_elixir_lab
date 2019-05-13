defmodule KafkaElixirLab.ScalaPubConsumer do
  use KafkaEx.GenConsumer
  require Logger

  def handle_message_set(message_set, state) do
    for message <- message_set do
      if message.key == "scala-pub" do
        Logger.debug(fn -> "message: " <> inspect(message) end)
      else
        Logger.debug("I am not interested on my own messages:" <> inspect(message))
      end
    end

    {:async_commit, state}
  end
end
