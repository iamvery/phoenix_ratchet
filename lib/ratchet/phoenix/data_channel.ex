defmodule Ratchet.Phoenix.DataChannel do
  use Phoenix.Channel

  def join("data:" <> _topic, _payload, socket) do
    {:ok, socket}
  end
end
