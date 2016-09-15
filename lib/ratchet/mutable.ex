defmodule Ratchet.Mutable do
  @event "data"

  import Ratchet.Phoenix.DataChannel, only: [prefix: 0]
  import Ratchet.Payload

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
    endpoint.broadcast "#{prefix}:#{scope}", @event, %{scope => prepare(data)}
  end
end
