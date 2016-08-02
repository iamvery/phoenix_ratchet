defmodule Ratchet.Endpoint do
  @moduledoc "TODO"

  defmacro __using__(_) do
    quote do
      # TODO make socket configurable
      socket "/data", Ratchet.Phoenix.DataSocket
    end
  end
end
