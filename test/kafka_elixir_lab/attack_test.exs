defmodule KafkaElixirLab.AttackTest do
  use ExUnit.Case, async: true
  alias KafkaElixirLab.Attack

  setup do
    {:ok, attack_pid} = Attack.start_link(nil)
    %{pid: attack_pid}
  end

  test "retrieve the initial state of a Attack Agent", %{pid: attack_pid} do
    assert Attack.current(attack_pid) == %Attack{}
  end
end
