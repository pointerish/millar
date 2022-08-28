defmodule Millar do
  @doc """
  Returns a string representing an org file with SCP article
  """
  def get(scp_number) do
    case :ets.lookup(:scp_collection, scp_number) do
      [{scp_number, _content}] ->
        # TODO: Write HTML to Org file
        IO.inspect("#{scp_number}")

      [] ->
        # TODO: Cache into ETS when not found, do request and return data
        :error
    end
  end
end
