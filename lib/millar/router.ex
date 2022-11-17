defmodule Millar.Router do
  use Plug.Router
  alias Millar

  plug(Plug.Static, at: "/", from: :millar)
  plug(:match)
  plug(:dispatch)

  get "/scps/:scp_number" do
    %{"scp_number" => scp_number} = conn.path_params

    send_json_response(conn, Millar.get(scp_number))
  end

  match _ do
    send_resp(conn, 404, "404")
  end

  defp send_json_response(conn, response_data) do
    conn
    |> send_resp(200, response_data)
  end
end
