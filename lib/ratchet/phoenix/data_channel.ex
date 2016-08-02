defmodule Ratchet.Phoenix.DataChannel do
  @moduledoc "TODO"

  use Phoenix.Channel

  @prefix "data"
  def prefix, do: @prefix

  def join("#{@prefix}:" <> _topic, _payload, socket) do
    {:ok, socket}
  end
end
