defmodule Ratchet.Plug.DataTest do
  use ExUnit.Case, async: true
  alias Ratchet.Plug.Data
  doctest Data

  defmodule Foo do
    use Data, for: :foos
    def data(conn), do: "foo #{conn.assigns.data.bar}"
  end

  defmodule Bar do
    use Data, for: :bars
    def data(_conn), do: nil
    def scopes(conn), do: ["some", conn.assigns.data.bar]
  end

  test "property method defined" do
    assert Foo.property == :foos
  end

  @conn %Plug.Conn{assigns: %{data: %{bar: "value"}}}

  test "pluggable" do
    conn = Foo.call(@conn, [])

    assert conn == %Plug.Conn{assigns: %{data: %{bar: "value", foos: "foo value"}}}
  end

  describe "topic" do
    test "has no scopes by default" do
      assert Foo.topic(@conn) == "data:foos"
    end

    test "scopes is overridable" do
      assert Bar.topic(@conn) == "data:some:value:bars"
    end
  end
end
