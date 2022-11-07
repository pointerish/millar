defmodule Millar do
  @doc """
  Returns a string representing an org file with SCP article
  """
  require Logger
  alias Millar.Scps
  alias Millar.Spider

  def get(scp_number) do
    # TODO: Maybe consider Dets and Pockets library to store
    # SCPs permanently and just use Ets for the latest N SCPs visited
    case GenServer.call(Scps, {:get, scp_number}) do
      {:ok, scp_data} ->
        Logger.info("Extracting SCP data from ETS.")
        scp_data

      _ ->
        Logger.info("Extracting SCP data from WikiDot.")
        %{content: content} = Spider.get_scp(scp_number)
        GenServer.call(Scps, {:put, scp_number, content})

        content
    end
  end
end
