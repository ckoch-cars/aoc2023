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

  def one_two(input) do
    input
    |> String.split("\n")
    |> Enum.reduce(0, fn
      nil, acc -> acc
      "", acc -> acc
      row, acc ->
        values = Regex.scan(~r/one|two|three|four|five|six|seven|eight|nine|\d/, row)
        i0 = values |> Enum.at(0) |> int_string_to_int()

        rev_row = String.reverse(row)
        values = Regex.scan(~r/enin|thgie|neves|xis|evif|ruof|eerht|owt|eno|\d/, rev_row)

        i1 = values
        |> Enum.at(0)
        |> then(fn [val] -> [String.reverse(val)] end)
        |> int_string_to_int()

      acc + String.to_integer(i0 <> i1)
    end)
  end

  @int_strings ~w(one two three four five six seven eight nine)
  def int_string_to_int([int]) when int in @int_strings do
    case int do
      "one" -> "1"
      "two" -> "2"
      "three" -> "3"
      "four" -> "4"
      "five" -> "5"
      "six" -> "6"
      "seven" -> "7"
      "eight" -> "8"
      "nine" -> "9"
    end
  end

  def int_string_to_int([int]), do: int

end
