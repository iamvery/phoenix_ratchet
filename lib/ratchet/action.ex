defmodule Ratchet.Action do
  @moduledoc "TODO"

  defmacro __using__([]) do
    quote do
      import unquote(__MODULE__)
    end
  end

  defmacro action(event, do: body) do
    quote do
      def unquote(event)(var!(conn)) do
        unquote(body)
      end
    end
  end
end
