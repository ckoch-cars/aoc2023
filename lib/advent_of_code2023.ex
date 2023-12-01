defmodule AdventOfCode2023 do
  @moduledoc """
  Documentation for `AdventOfCode2023`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AdventOfCode2023.hello()
      :world

  """
  def hello do
    :world
  end

  def one(_args \\ []) do
    "lib/fixtures/input1.txt"
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(0, fn
      nil, acc -> acc
      "", acc -> acc
      row, acc ->
      [i0] = Regex.run(~r/\d/, row)
      [i1] = Regex.run(~r/\d/, String.reverse(row))
      acc + String.to_integer(i0 <> i1)
    end)
  end
end
