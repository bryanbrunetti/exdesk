defmodule ExDeskOauthTest do
  use ExUnit.Case, async: false

  setup_all do
    ExDesk.configure(
      site_name: "zzz-bryan.desk.com",
      key: "HP3wdXcB2TTnMOxhivu0",
      secret: "USQHgtxMN1G7pQJxlGLfoomtJe5nwsCHUB6K6Cjq",
      token: "qCIbe4yMb7RaEJhi9WXe",
      token_secret: "YymAnVSGO4TMIEVZRzhVHYbnMENemjy1LLxyEpEI"
      )
  end

  # test "Authenticating and accessing via OAuth" do
  #   {:ok, response, _headers, _status_code} = ExDesk.list("brands")
  #   assert response["total_entries"] == 3
  # end

  test "Creating a label via OAuth" do
    {:ok, response, _headers, _status_code} = ExDesk.create("customers", [first_name: "Bryan", last_name: "Brunetti"])
    IO.puts inspect response
    # assert label != %{"message" => "Resource Not Found"}
    # assert label["name"] == "A Label"
  end

end
