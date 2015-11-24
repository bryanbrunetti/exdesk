defmodule ExDesk.Request.OAuth do
require IEx
  def call(method, endpoint, params, headers) do
IO.puts inspect params
    consumer = {ExDesk.config[:key], ExDesk.config[:secret], :hmac_sha1}
    apply(:oauth,
      method,
      [to_char_list(endpoint), params, consumer, ExDesk.config[:token], ExDesk.config[:token_secret]]
    ) |> parse
  end

  def parse(response) do
    {status, {status_code, headers, body}} = response
    {status, struct(ExDesk.Response, %{body: body, status_code: elem(status_code, 1), headers: headers})}
  end
end
