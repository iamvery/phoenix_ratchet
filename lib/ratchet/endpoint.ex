defmodule Ratchet.Endpoint do
  @moduledoc """
  Use this module as an extension to add a Ratchet data socket to your Phoenix.Endpoint.

      defmodule YourApp.Endpoint
        # ...
        use Ratchet.Endpoint
        # ...
      end
  """

  defmacro __using__(_) do
    quote do
      # TODO make socket configurable
      socket "/ratchet", Ratchet.Phoenix.DataSocket
    end
  end
end
