defmodule Ratchet.Endpoint do
  defmacro __using__(_) do
    quote do
      socket "/data", Ratchet.Phoenix.DataSocket
    end
  end
end
