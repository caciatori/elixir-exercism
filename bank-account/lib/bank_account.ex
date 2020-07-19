defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  use GenServer

  @doc """
  Open the bank. Makes the account available.
  """
  @type account :: pid
  @spec open_bank :: account
  def open_bank() do
    {:ok, pid} = GenServer.start_link(BankAccount, 0)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: :ok
  def close_bank(account), do: GenServer.stop(account)

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    if Process.alive?(account) do
      GenServer.call(account, :balance)
    else
      {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: :ok | {:error, :account_closed}
  def update(account, amount) do
    if Process.alive?(account) do
      GenServer.cast(account, {:deposit, amount})
    else
      {:error, :account_closed}
    end
  end

  @impl true
  @spec init(any) :: {:ok, integer()}
  def init(balance \\ 0), do: {:ok, balance}

  @impl true
  def handle_call(:balance, _from, balance), do: {:reply, balance, balance}

  @impl true
  def handle_cast({:deposit, value}, balance), do: {:noreply, value + balance}
end
