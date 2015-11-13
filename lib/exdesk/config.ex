defmodule ExDesk.Config do
  def current_scope do
    if Process.get(:exdesk_auth, nil), do: :process, else: :global
  end

  def get, do: get(current_scope)
  defp get(:global), do: Application.get_env(:exdesk, :auth, nil)
  defp get(:process), do: Process.get(:exdesk_auth, nil)

  def set(value), do: set(current_scope, value)
  def set(:global, value), do: Application.put_env(:exdesk, :auth, value)
  def set(:process, value) do
    Process.put(:exdesk_auth, value)
    :ok
  end
end
