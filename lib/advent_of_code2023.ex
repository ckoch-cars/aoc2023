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
  defp int_string_to_int([int]) when int in @int_strings do
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

  defp int_string_to_int([int]), do: int

  def day2_one(input, cubes) do
    parsed_input = parse(input)
    filtered = filter_for_cubes(parsed_input, cubes)
    |> IO.inspect(label: "filtered")

    Enum.reduce(filtered, 0, fn %{game_id: id}, acc -> id + acc end)
  end

  def day2_two(input) do
    parsed_input = parse(input)
    Enum.reduce(parsed_input, 0, fn %{maxes: maxes}, acc ->
      acc + Map.get(maxes, :red) * Map.get(maxes, :blue) * Map.get(maxes, :green)
    end)
    |> IO.inspect(label: "")
    # filtered = filter_for_cubes(parsed_input, cubes)
    # |> IO.inspect(label: "filtered")

    # Enum.reduce(filtered, 0, fn %{game_id: id}, acc -> id + acc end)
  end

  defp parse(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(fn row ->
      [game, tail] = String.split(row, ": ")
      game_id = game |> String.replace_prefix("Game ", "") |> String.to_integer()
      draws = String.split(tail, "; ")
      maxes = Enum.reduce(draws, %{red: 0, green: 0, blue: 0}, fn draw, acc ->
        values = String.split(draw, ", ")
        Enum.reduce(values, acc, fn val, acc ->
          [number, color] = String.split(val, " ")
            Map.update(acc, String.to_atom(color), 0, fn curr ->
              num = String.to_integer(number)
              if num > curr do
                num
              else
                curr
              end
            end)
        end)
      end)
      %{game_id: game_id, maxes: maxes, game: draws}
    end)
  end

  defp filter_for_cubes(parsed_input, limits) do
    Enum.filter(parsed_input, fn %{maxes: maxes} ->
      Map.get(maxes, :red) <= Map.get(limits, :red) and
        Map.get(maxes, :blue) <= Map.get(limits, :blue) and
        Map.get(maxes, :green) <= Map.get(limits, :green)
    end)

  end
end
