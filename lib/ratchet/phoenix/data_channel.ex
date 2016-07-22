defmodule Ratchet.Phoenix.DataChannel do
  use Phoenix.Channel

  @prefix "data"

  def prefix, do: @prefix

  def join("#{@prefix}:" <> _topic, _payload, socket) do
    {:ok, socket}
  end
end
