defmodule KafkaElixirLabTest do
  use ExUnit.Case
  doctest KafkaElixirLab

  test "greets the world" do
    assert KafkaElixirLab.hello() == :world
  end
end
