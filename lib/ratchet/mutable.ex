defmodule Ratchet.Mutable do
  @event "data"

  import Ratchet.Phoenix.DataChannel, only: [prefix: 0]

  defmacro __using__(opts) do
    quote do
      Module.put_attribute(__MODULE__, :endpoint, unquote(opts[:endpoint]))
      import unquote(__MODULE__)
    end
  end

  defmacro action(name, [mutates: scopes], do: body) do
    quote do
      def unquote(name)(var!(params)) do
        unquote(body) # TODO verify this complete successfully
        Enum.each unquote(scopes), fn {scope, data} ->
          broadcast @endpoint, scope, data
        end
      end
    end
  end

  def broadcast(endpoint, scope, data) do
    # data in this case may not be serializable to JSON. e.g. some valid
    # ratchet data contains tuples which cannot be serialized with Poison
    endpoint.broadcast "#{prefix}:#{scope}", @event, %{scope => data}
  end
end
