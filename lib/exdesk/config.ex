defmodule ExDesk.Config do
  def current_scope do
    if Process.get(:exdesk_auth, nil), do: :process, else: :global
  end

  def get, do: get(current_scope)

  defp get(:global) do
    case System.get_env("EXDESK_CONFIG") do
      nil -> Application.get_env(:exdesk, :auth, nil)
      "" -> Application.get_env(:exdesk, :auth, nil)
      config ->
        [sn, e, p] = String.split(config, ",")
        [site_name: sn, email: e, password: p]
    end
  end

  defp get(:process), do: Process.get(:exdesk_auth, nil)

  def set(value), do: set(current_scope, value)

  def set(:global, value), do: Application.put_env(:exdesk, :auth, value)

  def set(:process, value) do
    Process.put(:exdesk_auth, value)
    :ok
  end

end
