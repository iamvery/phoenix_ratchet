defmodule Ratchet.Plug.Data do
  @moduledoc "TODO"

  @behaviour Plug

  def init(_opts), do: false

  @doc """
  Initialize connection data

      iex> conn = %Plug.Conn{}
      iex> Data.call(conn, [])
      %Plug.Conn{assigns: %{data: %{}}}
  """
  def call(conn, _opts) do
    update_in conn.assigns, &Map.put(&1, :data, %{})
  end
end
