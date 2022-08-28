defmodule Millar do
  @doc """
  Returns a string representing an org file with SCP article
  """
  alias Millar.Scps
  alias Millar.Spider

  def get(scp_number) do
    case GenServer.call(Scps, {:get, scp_number}) do
      {:ok, scp_data} ->
        scp_data

      _ ->
        %{content: content} = Spider.get_scp(scp_number)
        GenServer.call(Scps, {:put, scp_number, content})

        content
    end
  end
end
