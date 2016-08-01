defmodule Ratchet.Action do
  @moduledoc "TODO"

  defmacro action(event, do: body) do
    quote do
      def unquote(event)(var!(conn)) do
        unquote(body)
      end
    end
  end
end
