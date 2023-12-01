defmodule AdventOfCode2023Test do
  use ExUnit.Case
  doctest AdventOfCode2023

  test "greets the world" do
    assert AdventOfCode2023.hello() == :world
  end

  test "one" do
    assert AdventOfCode2023.one() == 54390
  end
end
