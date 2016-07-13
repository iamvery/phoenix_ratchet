defmodule Ratchet.Mutable do
  defmacro __using__(opts) do
    quote do
      Module.put_attribute(__MODULE__, :endpoint, unquote(opts[:endpoint]))
      import unquote(__MODULE__)
    end
  end

  defmacro action(name, [mutates: scopes], do: body) do
    quote do
      def unquote(name)(var!(params)) do
        unquote(body)
        Enum.each unquote(scopes), fn {scope, data} ->
          broadcast @endpoint, scope, data
        end
      end
    end
  end

  def broadcast(endpoint, scope, data) do
    # data in this case may not be serializable to JSON. e.g. some valid
    # ratchet data contains tuples which cannot be serialized with Poison
    endpoint.broadcast "data:#{scope}", "data", %{scope => data}
  end
end
