defmodule Millar.Spider do
  require Logger

  @base_url "https://scp-wiki.wikidot.com/scp-{number}"

  def get_scp(number) when is_integer(number),
    do: pad_when_integer(number) |> get_scp()

  def get_scp(number) do
    number = pad_when_string(number)

    case do_get_scp(number) do
      {:error, reason} -> {:error, reason}
      response -> parse_scp_response(response)
    end
  end

  defp parse_scp_response(%HTTPoison.Response{status_code: 200, body: body}) do
    Logger.info("Parsing SCP response.")

    body = Floki.parse_document!(body)

    %{
      title: Floki.find(body, "#page-title"),
      content: Floki.find(body, "#page-content") |> Floki.raw_html()
    }
  end

  defp parse_scp_response(%HTTPoison.Response{status_code: code}),
    do: {:error, %{status_code: code}}

  defp do_get_scp(scp_number) do
    url = Regex.replace(~r/\{number\}/, @base_url, scp_number)

    Logger.info("Spidering SCP from #{url}")

    case HTTPoison.get(url) do
      {:ok, response} ->
        response

      {:error, %{reason: reason}} ->
        {:error, reason}
    end
  end

  defp pad_when_integer(number) when number < 100 and number >= 10, do: "0#{number}"

  defp pad_when_integer(number), do: "00#{number}"

  defp pad_when_string(number) when is_binary(number) do
    if String.length(number) == 2 do
      "0#{number}"
    end
  end

  defp pad_when_string(number) when is_binary(number) do
    if String.length(number) == 1 do
      "00#{number}"
    end
  end
end
