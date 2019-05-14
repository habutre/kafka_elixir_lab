defmodule KafkaElixirLab.Attack do
  use Agent
  alias KafkaElixirLab.Attack

  defstruct [:player, :received, :sent, :damage]

  def start_link(_opts) do
    Agent.start_link(fn -> %Attack{} end)
  end

  def current(attack_pid) do
    Agent.get(attack_pid, fn attack -> attack end)
  end
end
