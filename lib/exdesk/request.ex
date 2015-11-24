defmodule ExDesk.Request do

  def get(endpoint, options \\ []) do
    url(endpoint)
    |> do_request(:get, [], options)
    |> decode_response
  end

  def post(endpoint, data \\ []) do
    url(endpoint)
    |> do_request(:post, data)
    |> decode_response
  end

  def delete(endpoint) do
    url(endpoint)
    |> do_request(:delete)
    |> decode_response
  end

  def patch(endpoint, data) do
    url(endpoint)
    |> do_request(:patch, data)
    |> decode_response
  end

  defp encode(data) do
    data
    |> Enum.into(%{})
    |> Poison.encode!
  end

  defp decode_response(response) do
    {status, response} = response
    {status, decode(response.body), response.headers, response.status_code}
  end

  defp decode(""), do: ""
  defp decode(response), do: Poison.decode!(response)

  defp url(endpoint) do
    "https://" <> ExDesk.config[:site_name] <> versioned_path <> to_string(endpoint)
  end

  def params_exists([]), do: raise %{message: "Auth parameters are not set, use ExDesk.configure"}
  def params_exist(params), do: params

  defp versioned_path, do: "/api/v2/"

  defp do_request(endpoint, method, params \\ [], headers \\ %{}) do
    case ExDesk.config do
      [site_name: _, email: _, password: _] -> ExDesk.Request.BasicAuth.call(method, endpoint, params |> encode, headers)
      [site_name: _, key: _, secret: _, token: _, token_secret: _] -> ExDesk.Request.OAuth.call(method, endpoint, params, headers)
      _ -> raise %{message: "Auth parameters are not set, use ExDesk.configure"}
    end
  end

end
