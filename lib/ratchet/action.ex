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
      def unquote(event)(var!(conn)) do
        unquote(body)
      end
    end
  end
end
