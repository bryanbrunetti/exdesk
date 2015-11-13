defmodule ExDesk do
  @moduledoc """
  A client interface to the Desk.com API
  """
    use Application

    def start(_type, _args) do
      HTTPoison.start
      ExDesk.Supervisor.start_link
    end

  @moduledoc """
  Accepts authorization config data
  The auth data can be scoped globally ( default) or per process

  Globally:
  iex> ExDesk.configure(
  ...>   site_name: "test.desk.com",
  ...>   email: "abc@mydomain.com",
  ...>   password: "mypassword"
  ...> )
  :ok
  iex> ExDesk.config
  [site_name: "test.desk.com", email: "abc@mydomain.com", password: "mypassword"]

  Scoped to the current process:
  iex> ExDesk.configure(:process, email: "agent@myemail.com", password: "abc123", site_name: "test.desk.com")
  :ok
  iex> ExDesk.config
  [email: "agent@myemail.com", password: "abc123", site_name: "test.desk.com"]
  """
  defdelegate configure(auth), to: ExDesk.Config, as: :set
  defdelegate configure(scope, auth), to: ExDesk.Config, as: :set
  defdelegate config, to: ExDesk.Config, as: :get

  @moduledoc """
  Creates a resources at `endpoint` with `data`

  ExDesk.create("labels", [name: "A Label", description: "a description", types: ["case"], enabled: true, color: "purple"])
  """
  defdelegate create(endpoint, data), to: ExDesk.Request, as: :post

  @moduledoc """
  Retrieves a single resource at `endpoint` with optional `query` params

  ExDesk.show("cases/12345", [fields: "subject"])
  """
  defdelegate show(endpoint), to: ExDesk.Request, as: :get
  defdelegate show(endpoint, params), to: ExDesk.Request, as: :get

  @moduledoc """
  Retrieves a list of resources at `endpoint` with optional `query` param

  ExDesk.list("cases", [per_page: 10])
  """
  defdelegate list(endpoint), to: ExDesk.Request, as: :get
  defdelegate list(endpoint, params), to: ExDesk.Request, as: :get

  @moduledoc """
  Updates a resource at `endpoint` with `data`

  ExDesk.update("cases/12345", [subject: "Updated Subject"])
  """
  defdelegate update(endpoint, data), to: ExDesk.Request, as: :patch

  @moduledoc """
  Deletes resource at `endpoint`

  ExDesk.delete("cases/12345")
  """
  defdelegate delete(endpoint), to: ExDesk.Request

end
