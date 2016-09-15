defmodule Ratchet.ActionTest do
  use ExUnit.Case, async: true
  alias Ratchet.Action
  doctest Action

  defmodule Endpoint do
    def broadcast(topic, event, payload) do
      send self, {topic, event, payload}
    end
  end

  defmodule Data do
    use Ratchet.Plug.Data, for: :foo
    def data(_conn), do: {"foo data", lol: "wat"}
  end

  defmodule Foo do
    use Action, endpoint: Endpoint

    action :create, changes: [Data] do
      conn.assigns.value
    end
  end

  describe "create action" do
    @conn %Plug.Conn{assigns: %{value: :foo}}

    test "returns result of body" do
      result = Foo.create(@conn)

      assert result == :foo
    end

    test "broadcasts data on endpoint" do
      Foo.create(@conn)

      assert_receive {"data:foo", "data", %{foo: %{_content_: "foo data", _attrs_: %{_attrs_: true, lol: "wat"}}}}
    end

    @tag :skip
    test "does not broadcast when result fails"
  end
end
