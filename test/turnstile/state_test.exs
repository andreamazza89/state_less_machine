defmodule TurnstileStateTest do
  use ExUnit.Case
  import Turnstile.State

  test "it can be started in the locked state" do
    state_id = begin(:locked)

    assert current_state(state_id) === :locked
  end

  test "it can be started in the open state" do
    state_id = begin(:open)

    assert current_state(state_id) === :open
  end

  test "it goes locked->open when paid" do
    state_id = begin(:locked)

    update_state_with_input(state_id, :paid)

    assert current_state(state_id) === :open
  end

  test "it stays open if paying again" do
    state_id = begin(:open)

    update_state_with_input(state_id, :paid)

    assert current_state(state_id) === :open
  end

  test "it goes open->locked after a push" do
    state_id = begin(:open)

    update_state_with_input(state_id, :push)

    assert current_state(state_id) === :locked
  end

  test "it stays locked if there is a push" do
    state_id = begin(:locked)

    update_state_with_input(state_id, :push)

    assert current_state(state_id) === :locked
  end

end
