defmodule Turnstile.State do

  def begin(initial_state) do
    {:ok, id} = Agent.start(fn() -> initial_state end)
    id
  end

  def current_state(id) do
    Agent.get(id, &(&1))
  end

  def update_state_with_input(id, :paid) do
    do_update_state_with_input(id, :open)
  end

  def update_state_with_input(id, :push) do
    do_update_state_with_input(id, :locked)
  end

  defp do_update_state_with_input(id, new_state) do
    Agent.update(id, fn(old_state) -> new_state end)
  end

end
