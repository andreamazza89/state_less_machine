defmodule Turnstile do
  import Turnstile.StateProcessor

  def start(lock_id, state_id) do

    receive do
      {:paid, payment_id} ->
        handle_payment_message(payment_id, state_id, lock_id)
        start(lock_id, state_id)
      :push ->
        send lock_id, :close
        get_and_update_state(state_id, :push)
        start(lock_id, state_id)
    end
  end

  defp handle_payment_message(payment_id, state_id, lock_id) do
    new_state = get_and_update_state(state_id, :paid)
    case new_state do
      {:open, :refund} ->
        send payment_id, :refund
      :open ->
        send lock_id, :open
    end
  end

  defp get_and_update_state(state_id, input) do
    Agent.get_and_update(state_id, fn(old_state) ->
      new_state = process(old_state, input)
      {new_state, new_state}
    end)
  end

end

defmodule Lock do

  def start do
    receive do
      :close ->
        IO.puts "closing the lock"
        start()
      :open ->
        IO.puts "opening the lock"
        start()
    end
  end

end
