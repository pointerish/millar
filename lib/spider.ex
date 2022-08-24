defmodule Millar.Spider do
  @base_url "https://scp-wiki.wikidot.com/scp-{number}"

  def get_scp(number) when is_integer(number),
    do: Integer.to_string(number) |> get_scp()

  def get_scp(number) do
    case do_get_scp(number) do
      :get_scp_error -> raise("Unable to retrieve SCP-#{number}.")
      response -> parse_scp_response(response)
    end
  end

  defp parse_scp_response(%HTTPoison.Response{status_code: 200, body: body}) do
    %{
      title: Floki.find(body, "#page-title"),
      content: Floki.find(body, "#page-content")
    }
  end

  defp do_get_scp(scp_number) do
    url = Regex.replace(~r/\{number\}/, @base_url, scp_number)

    case HTTPoison.get(url) do
      {:ok, response} ->
        response

      {:error, _} ->
        :get_scp_error
    end
  end
end
