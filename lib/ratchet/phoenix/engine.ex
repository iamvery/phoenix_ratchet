defmodule Ratchet.Phoenix.Engine do
  @moduledoc """
  This is the Phoenix.Template.Engine that allows Ratchet templates to be used with Phoenix.
  """

  @behaviour Phoenix.Template.Engine

  import Ratchet.Renderer, only: [parse: 1, compile: 1]
  import Ratchet.Transformer, only: [transform: 2]

  def compile(path, _name) do
    path
    |> read
    |> parse
    |> transform("assigns.data")
    |> compile
    |> EEx.compile_string(engine: Phoenix.HTML.Engine, file: path, line: 1)
  end

  defp read(path), do: File.read!(path)
end
