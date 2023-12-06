defmodule AdventOfCode2023.Day4 do

  def one(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.reduce(0, fn row, acc ->
      [game, tail] = String.split(row, ": ")
      _card_id = game |> String.replace_prefix("Card", "") |> String.trim_leading() |> String.to_integer()
      [winners, draws] = String.split(tail, " | ")
      winners = winners |> String.split() |> MapSet.new()
      draws = draws |> String.split() |> MapSet.new()
      winning_numbers = MapSet.intersection(winners, draws)

      if MapSet.size(winning_numbers) == 0 do
        acc
      else
        Integer.pow(2, MapSet.size(winning_numbers) - 1) + acc
      end
    end)
  end

  def two(input) do
    cards = input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(fn row ->
      [game, tail] = String.split(row, ": ")
      card_id = game |> String.replace_prefix("Card", "") |> String.trim_leading() |> String.to_integer()
      # |> IO.inspect(label: "card_id")
      [winners, draws] = String.split(tail, " | ")
      winners = winners |> String.split() |> MapSet.new()
      draws = draws |> String.split() |> MapSet.new()
      {card_id, MapSet.size(MapSet.intersection(winners, draws))}
    end)
    # |> IO.inspect(label: "cards")
    # Enum.reduce(cards, 0, fn {_row, winners} = card, acc ->
    #   winners + eval_row(card, cards, acc) |> IO.inspect(label: "card eval")
    # end)

    # Enum.at(cards, 6, {6, 0}) |> IO.inspect(label: "")
    # Enum.map(cards, fn {row, winners} = card ->
    #   eval_row(card, cards, 1)
    #    # |> IO.inspect(label: "card eval #{row}")
    # end)
    # |> Enum.sum()
    # # |> Kernel.+(Enum.count(cards))
    # |> IO.inspect(label: "evaluated")

    Enum.reduce(cards, 0, &eval_row(&1, cards, &2))
    # |> Enum.sum()
    # # |> Kernel.+(Enum.count(cards))
    # |> IO.inspect(label: "evaluated")

  end

  defp eval_row({_row, 0}, _card_eval, acc), do: acc + 1
  defp eval_row({row, winners}, card_eval, acc) do
    acc = acc + 1
    Enum.reduce(1..winners, acc, fn idx, acc ->
      winner_row = row - 1 + idx
      # |> IO.inspect(label: "winner_row")
      eval_row(Enum.at(card_eval, winner_row, {winner_row, 0}), card_eval, acc)
    end )
    # for idx <- 1..winners do
    #   # acc = acc + 1
    #   # |> IO.inspect(label: "acc ")
    #   eval_row(Enum.at(card_eval, row - 1 + idx, {row - 1 + idx, 0}), card_eval, acc)
    # end
    # |> Enum.sum()
    # |> IO.inspect(label: "reduce")
  end
end

