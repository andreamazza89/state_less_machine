defmodule Turnstile.State do

  def begin do
    {:ok, id} = Agent.start(fn() -> :locked end)
    id
  end

  def update_state_with_input(id, :paid) do
    Agent.update(id, fn(old_state) -> :open end)
  end

  def current_state(id) do
    Agent.get(id, &(&1))
  end

end
