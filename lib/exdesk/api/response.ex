defmodule ExDesk.API.Response do
  @derive [Poison.Encoder]
  defstruct total_entries: 0, _embedded: %{entries: []}, links: [], next: '', previous: ''
end
