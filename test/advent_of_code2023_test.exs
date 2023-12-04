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

  test "day2_one test" do
    input = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    cubes = %{red: 12, green: 13, blue: 14}

    assert AdventOfCode2023.day2_one(input, cubes) == 8
  end

  test "day2_one" do
    input = File.read!("lib/fixtures/input2.txt")
    cubes = %{red: 12, green: 13, blue: 14}

    assert AdventOfCode2023.day2_one(input, cubes) == 2617
  end

  test "day2_two test" do
    input = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    assert AdventOfCode2023.day2_two(input) == 2286
  end

  test "day2_two" do
    input = File.read!("lib/fixtures/input2.txt")

    assert AdventOfCode2023.day2_two(input) == 59795
  end

  describe "Day3" do
    test "day3_one test" do
      input = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """
      assert AdventOfCode2023.Day3.day3_one(input) == 4361
    end

    test "day3_one full" do
      input = File.read!("lib/fixtures/input3.txt")
      assert AdventOfCode2023.Day3.day3_one(input) == 525119
    end

    test "day3_two test with two in row" do
      input = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*22....
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """

      # gears 467 * 35 + 755 * 598
      assert AdventOfCode2023.Day3.day3_two(input) == 481409
    end

    test "day3_two test with adjacent" do
      input = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """

      # gears 467 * 35 + 755 * 598
      assert AdventOfCode2023.Day3.day3_two(input) == 467835
    end

    test "day3_two full" do
      input = File.read!("lib/fixtures/input3.txt")
      assert AdventOfCode2023.Day3.day3_two(input) == 525119
    end

  end
end
