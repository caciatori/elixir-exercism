defmodule BankAccount.Server do
  use GenServer

  @impl true
  def init(balance \\ 0) do
    {:ok, balance}
  end

  @impl true
  def handle_call(:balanace, from, balance) do
    {:reply, from, balance}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end
