defmodule Ratchet.Phoenix.DataSocket do
  @moduledoc """
  This is the Phoenix.Socket used by the Ratchet.Endpoint socket.
  """

  use Phoenix.Socket
  import Ratchet.Phoenix.DataChannel, only: [prefix: 0]

  channel "#{prefix}:*", Ratchet.Phoenix.DataChannel
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
