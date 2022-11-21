defmodule Millar.Scps.Persistance do
  use GenServer

  @persistance_location System.get_env("MILLAR_PERSISTANCE") || "tmp/"

  @impl true
  def init(_arg), do: Pockets.new(:scps_persistance, @persistance_location)

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

  defp get(key), do: Pockets.get(:scps_persistance, key)

  defp put(key, value), do: Pockets.put(:scps_persistance, key, value)
end
