defmodule AdventOfCode2023.Part2 do

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

end