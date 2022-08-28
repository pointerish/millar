defmodule Millar.Scps do
  use GenServer

  @impl true
  def init(arg) do
    :ets.new(:scps, [:set, :public, :named_table])

    {:ok, arg}
  end

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

  defp get(key) do
    case :ets.lookup(:scps, "scps") do
      [] -> nil
      [{_key, nil}] -> nil
      [{_key, value}] -> Map.get(value, key)
    end
  end

  defp put(key, value) do
    :ets.insert_new(:scps, {key, value})
  end
end
