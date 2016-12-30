defmodule TurnstileStateTest do
  use ExUnit.Case
  import Turnstile.State

  test "it is locked when first turned on" do
    state_id = begin()

    assert current_state(state_id) === :locked
  end

  test "it becomes open when paid" do
    state_id = begin()

    update_state_with_input(state_id, :paid)

    assert current_state(state_id) === :open
  end

end
