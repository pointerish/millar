defmodule Millar.Scps do
  use GenServer

  @impl true
  def init(_), do: Pockets.new(:scps)

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, get(key), state}
  end

  @impl true
  def handle_call({:put, key, value}, _from, state) do
    {:reply, put(key, value), state}
  end

  defp get(key), do: Pockets.get(:scps, key)

  defp put(key, value), do: Pockets.put(:scps, key, value)
end
