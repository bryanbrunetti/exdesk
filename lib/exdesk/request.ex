defmodule ExDesk.Request do

  def get(endpoint, options \\ []) do
    options = [params: options] |> Keyword.merge(basic_auth)

    url(endpoint)
    |> HTTPoison.get!([], options)
    |> decode_body
  end

  def post(endpoint, data \\ []) do
    url(endpoint)
    |> HTTPoison.post!(data |> encode, %{}, basic_auth)
    |> decode_body
  end

  def delete(endpoint) do
    response = url(endpoint) |> HTTPoison.delete!(%{}, basic_auth)
    if response.status_code == 204, do: {:ok}
  end

  def patch(endpoint, data) do
    url(endpoint)
    |> HTTPoison.patch!(data |> encode, %{}, basic_auth)
    |> decode_body
    |> Enum.reduce(%{}, fn ({k, v}, accumulator) -> Map.put(accumulator, String.to_atom(k), v) end)
  end

  defp encode(data), do: data |> Enum.into(%{}) |> Poison.encode!

  defp decode_body(response) do
    response.body
    |> Poison.decode!
    |> Enum.reduce(%{}, fn ({k, v}, accumulator) -> Map.put(accumulator, String.to_atom(k), v) end)
  end


  defp url(endpoint) do
    "https://" <> ExDesk.config[:site_name] <> versioned_path <> fix_path(endpoint)
  end

  defp basic_auth do
    config = ExDesk.config |> params_exist
    [hackney: [basic_auth: {config[:email], config[:password]}]]
  end

  def params_exists([]), do: raise %{message: "Auth parameters are not set, use ExDesk.configure"}
  def params_exist(params), do: params

  defp versioned_path, do: "/api/v2/"

  defp fix_path(path), do: String.replace(to_string(path), ~r/^\/api\/v2/, "")

  def auth_module([site_name: _, email: _, password: _]), do: ExDesk.Auth.Basic
  def auth_module([site_name: _, consumer_key: _, consumer_secret: _, access_token: _, access_token_secret: _]), do: ExDesk.Auth.OAuth
end
