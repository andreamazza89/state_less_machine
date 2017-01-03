# StateLessMachine

A playground for state machines.

### Installation

- Install Elixir/Erlang.
- Clone this repo `git clone https://github.com/andreamazza89/state_less_machine.git`
- Move into the repo and fetch all dependencies `cd state_less_machine && mix deps.get`
- See specifics for the various machines below.

##### Turnstile

This simulates turnstile operation over multiple processes.

- Start an Agent process to store the turnstile's state `{:ok, state} = Agent.start(fn -> :locked end)`
- Start the lock process `lock = spawn(&Lock.start/0)`
- Start the turnstile `turnstile = spawn(Turnstile, :start, [lock, state])`

You can now see the turnstile in action, by either sending it a payment message
(`{:paid,payment_id}`, where *payment_id* is the process id of the payment
provider) or a `:push` message.

If sending a payment a second time, the system will not re-open the lock and send
a :refund message to the given *payment_id*.
