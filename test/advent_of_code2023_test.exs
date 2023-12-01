defmodule AdventOfCode2023Test do
  use ExUnit.Case
  doctest AdventOfCode2023

  test "greets the world" do
    assert AdventOfCode2023.hello() == :world
  end

  test "one" do
    assert AdventOfCode2023.one() == 54390
  end

  test "one_two test" do
    input = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
    assert AdventOfCode2023.one_two(input) == 281
  end

  test "one_two edge" do
    input = """
    eighthree
    sevenine
    """
    assert AdventOfCode2023.one_two(input) == 83 + 79
  end

  test "one_two full" do
    input1 = File.read!("lib/fixtures/input1.txt")

    assert AdventOfCode2023.one_two(input1) == 54277
  end
end
