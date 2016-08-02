defmodule Ratchet.Plug.Data do
  @moduledoc """
  This module may be used in two ways:

  * As a plug to initialize ratchet data on the connection.
  * As an extension to create your own pluggable data modules.

  ## Data Initialization

  To initialize data on your connection, plug this module somewhere in your stack.
  You might do this in a Phoenix router pipeline.

      defmodule YourApp.Router do
        # ...
        pipeline :browser do
          # ...
          plug Ratchet.Plug.Data
        end
        # ...
      end

  ## Extend Your Own Data modules

  The recommended idiom for building data is by plugging so-called "data-modules" in your stack.
  This module may be used to extend such a module.

      defmodule YourApp.UserData do
        use Ratchet.Plug.Data, for: :user
        def data(_conn), do: %{id: 1, name: "Jay"}
      end

  Now this module may be plugged in to initialize the connection with user data.

      defmodule YourApp.UserController do
        # ...
        plug YourData

        def show(conn, _params) do
          render conn, "show.html"
        end
      end
  """

  @callback data(Plug.Conn.t) :: any

  defmacro __using__([for: property]) do
    quote do
      @behaviour unquote(__MODULE__)

      def property, do: unquote(property)

      def scopes(_conn), do: []

      def topic(conn) do
        scopes(conn)
        |> Ratchet.Phoenix.DataChannel.topic(property)
      end

      @behaviour Plug
      def init(_opts), do: false
      def call(conn, _opts) do
        unquote(__MODULE__).merge(conn, %{property => data(conn)})
      end
    end
  end

  @behaviour Plug

  def init(_opts), do: false

  @doc """
  Initialize connection data

      iex> conn = %Plug.Conn{}
      iex> Data.call(conn, [])
      %Plug.Conn{assigns: %{data: %{}}}
  """
  def call(conn, _opts) do
    update_in conn.assigns, &Map.put(&1, :data, %{})
  end

  @doc """
  Merge new data into existing

      iex> conn = %Plug.Conn{assigns: %{data: %{foo: "bar"}}}
      iex> Data.merge(conn, %{baz: "qux"})
      %Plug.Conn{assigns: %{data: %{foo: "bar", baz: "qux"}}}
  """
  def merge(conn, data) do
    update_in conn.assigns.data, &Map.merge(&1, data)
  end
end
