defmodule ExDesk.OAuth do
  defp request(method, url, params) do
    oauth = ExDesk.config |> params_exist
    :oauth.request(method, url, params, consumer, oauth[:access_token], oauth[:access_token_secret])
  end

  def params_exists([]), do: raise %{message: "Auth parameters are not set, use ExDesk.configure"}
  def params_exist(params), do: params
end
