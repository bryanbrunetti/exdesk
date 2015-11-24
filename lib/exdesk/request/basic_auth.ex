defmodule ExDesk.Request.BasicAuth do
  def call(method, url, headers, options) do
    options = [params: options] |> Keyword.merge(credentials)
    apply(HTTPoison, method, [url, headers, options])
  end

  defp credentials do
    [hackney: [basic_auth: {ExDesk.config[:email], ExDesk.config[:password]}]]
  end

end
