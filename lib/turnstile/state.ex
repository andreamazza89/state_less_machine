defmodule Turnstile.StateProcessor do

  def process(_current_state = :locked, _input = :paid) do
    :open
  end

  def process(_current_state = :open, _input = :paid) do
    {:open, :refund}
  end

  def process(_current_state, _input = :push) do
    :locked
  end

end
