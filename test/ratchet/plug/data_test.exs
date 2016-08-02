defmodule Ratchet.Plug.DataTest do
  use ExUnit.Case, async: true
  alias Ratchet.Plug.Data
  doctest Data

  defmodule Foo do
    use Data, for: :foos
  end

  test "property method defined" do
    assert Foo.property == :foos
  end
end
