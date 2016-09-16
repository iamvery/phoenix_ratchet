defmodule Ratchet.Plug.DataTest do
  use ExUnit.Case, async: true
  alias Ratchet.Plug.Data
  doctest Data

  defmodule Bar do
    use Data, for: :bar
    def data(_), do: "value"
  end

  defmodule Foo do
    use Data, for: :foos
    plug Bar
    def data(conn), do: "foo #{conn.assigns.data.bar}"
  end

  test "property method defined" do
    assert Foo.property == :foos
  end

  @conn %Plug.Conn{assigns: %{data: %{}}}

  test "pluggable" do
    conn = Foo.call(@conn, [])

    assert conn == %Plug.Conn{assigns: %{data: %{bar: "value", foos: "foo value"}}}
  end
end
