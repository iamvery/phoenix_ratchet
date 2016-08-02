defmodule Ratchet.ActionTest do
  use ExUnit.Case, async: true
  alias Ratchet.Action
  doctest Action

  defmodule Foo do
    import Action

    action :create do
      conn.assigns.value
    end
  end

  describe "create action" do
    @conn %Plug.Conn{assigns: %{value: :foo}}

    test "returns result of body" do
      result = Foo.create(@conn)

      assert result == :foo
    end

    @tag :skip
    test "broadcasts data on endpoint"

    @tag :skip
    test "does not broadcast when result fails"
  end
end
