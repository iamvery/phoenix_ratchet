defmodule Ratchet.Action do
  @moduledoc "TODO"

  defmacro __using__([endpoint: endpoint]) do
    quote do
      Module.put_attribute(__MODULE__, :endpoint, unquote(endpoint))
      import unquote(__MODULE__)
    end
  end

  defmacro action(event, [changes: builders], do: body) do
    quote do
      def unquote(event)(var!(conn) = conn) do
        result = unquote(body)

        unquote(builders)
        |> Stream.map(&build(conn, &1))
        |> Enum.each(fn {topic, payload} -> broadcast(@endpoint, topic, "data", payload) end)

        result
      end
    end
  end

  def build(conn, builder) do
    topic = builder.topic(conn)
    payload = %{builder.property => builder.data(conn)}
    {topic, payload}
  end

  def broadcast(endpoint, topic, event, payload) do
    endpoint.broadcast(topic, event, payload)
  end
end
