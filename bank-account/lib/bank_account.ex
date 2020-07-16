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
  def close_bank(account) do
    GenServer.cast(account, :close_account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    if account_closed?(account) do
      {:error, :account_closed}
    else
      GenServer.call(account, :balance)
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: :ok | {:error, :account_closed}
  def update(account, amount) do
    if account_closed?(account) do
      {:error, :account_closed}
    else
      GenServer.cast(account, {:deposit, amount})
    end
  end

  defp account_closed?(account) do
    GenServer.call(account, :account_closed?)
  end

  @impl true
  def init(balance \\ 0) do
    {:ok, balance}
  end

  @impl true
  def handle_call(:balance, _from, balance) do
    {:reply, balance, balance}
  end

  @impl true
  def handle_call(:account_closed?, _from, status) do
    {:reply, status == :closed, status}
  end

  @impl true
  def handle_cast(:close_account, _balance) do
    {:noreply, :closed}
  end

  @impl true
  def handle_cast({:deposit, value}, balance) do
    {:noreply, value + balance}
  end
end
