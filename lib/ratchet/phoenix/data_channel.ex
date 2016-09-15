defmodule Ratchet.Phoenix.DataChannel do
  @moduledoc """
  This is the Phoenix.Channel used by Ratchet.Phoenix.Socket.
  """

  use Phoenix.Channel

  @prefix "data"
  def prefix, do: @prefix

  @doc """
  Builds a topic from the provided property, scopes, and prefix

      iex> DataChannel.topic(["bar", 1], "foo")
      "data:bar:1:foo"
      iex> DataChannel.topic([], "foo")
      "data:foo"
  """
  def topic(scopes, suffix) do
    [prefix | scopes] ++ [suffix]
    |> Enum.join(":")
  end

  def join("#{@prefix}:" <> _topic, _payload, socket) do
    {:ok, socket}
  end
end
