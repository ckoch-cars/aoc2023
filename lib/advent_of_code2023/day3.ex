defmodule AdventOfCode2023.Day3 do

  def day3_one(input) do
    rows = String.split(input, "\n")
    # char_grid = Enum.map(rows, &String.to_charlist/1)
    # |> IO.inspect(label: "char_grid")
    # #'0123456789'
    # # 48..57
    # # . = 46
    # # char_grid[2][2] == 51

    Enum.with_index(rows, fn row, index ->
      scan_for_nums = Regex.scan(~r/\d+/, row, return: :index)
      row_symbols = scan(row, ~r/[^\d^\.]/)
      prev_symbols = scan(Enum.at(rows, index - 1), ~r/[^\d^\.]/)
      next_symbols = scan(Enum.at(rows, index + 1, []), ~r/[^\d^\.]/)

      Enum.map(scan_for_nums, fn
        [] -> nil
        nil -> nil
        [{start, length}] ->
          if find_symbol_hit({start, length}, row_symbols) or
            find_symbol_hit({start, length}, prev_symbols) or
            find_symbol_hit({start, length}, next_symbols) do
            row
            |> String.slice(start, length)
            |> String.to_integer()
          end

      end)

    end)
    |> Enum.concat()
    |> Enum.reduce(0, fn
      nil, acc -> acc
      val, acc -> acc + val
    end)
  end

  defp scan([], _), do: []

  defp scan(row, regex) do
    Regex.scan(regex, row, return: :index)
  end

  defp find_symbol_hit({start, length}, row_symbols) do
    Enum.any?(row_symbols, fn
      [{symbol_pos, _}] -> symbol_pos >= start - 1  and symbol_pos <= start + length

      _ -> false
    end)
  end

  def day3_two(input) do
    rows = String.split(input, "\n")

    Enum.with_index(rows, fn row, index ->
      prev_i = index - 1
      next_i = index + 1
      scan_for_stars = Regex.scan(~r/\*/, row, return: :index)
      row_numbers = scan(row, ~r/\d+/)
      prev_numbers = scan(Enum.at(rows, prev_i), ~r/\d+/)
      next_numbers = scan(Enum.at(rows, next_i, []), ~r/\d+/)

      Enum.map(scan_for_stars, fn
        [] -> nil
        nil -> nil
        [{start, length}] ->
          [
            {index, find_number_hit({start, length}, row_numbers)},
            {prev_i, find_number_hit({start, length}, prev_numbers)},
            {next_i, find_number_hit({start, length}, next_numbers)}
          ]
          |> Enum.reduce([], fn
            {_index, []}, acc -> acc
            {idx, hits}, acc -> Enum.reduce(hits, acc, fn [{start, length}], acc ->
              number = rows
              |> Enum.at(idx)
              |> String.slice(start, length)
              |> String.to_integer()
              [number | acc]
            end)
          end)
      end)

    end)
    |> Enum.concat()
    |> Enum.reduce(0, fn row, acc ->
      acc + Enum.at(row, 0) * Enum.at(row, 1, 0)
    end)
  end

  defp find_number_hit({position, _length}, row_numbers) do
    Enum.filter(row_numbers, fn
      [{number_pos, length}] -> number_pos - 1 <= position and number_pos + length >= position

      _ -> []
    end)
  end
end