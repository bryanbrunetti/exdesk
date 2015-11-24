defmodule ExDesk.Response do

  defstruct body: '', status_code: 0, headers: []

  def new(params) do
    struct(ExDesk.Response, params)
  end

end
