defmodule TurnstileStateProcessorTest do
  use ExUnit.Case
  import Turnstile.StateProcessor

  test "it goes locked->open when paid" do
    current_state = :locked
    new_state = process(current_state, :paid)

    assert new_state === :open
  end

  test "it flags the refund required if already paid" do
    current_state = :open
    new_state = process(current_state, :paid)

    assert new_state === {:open, :refund}
  end

  test "it goes open->locked after a push" do
    current_state = :open
    new_state = process(current_state, :push)

    assert new_state === :locked
  end

  test "it stays locked if there is a push" do
    current_state = :locked
    new_state = process(current_state, :push)

    assert new_state === :locked
  end

end
