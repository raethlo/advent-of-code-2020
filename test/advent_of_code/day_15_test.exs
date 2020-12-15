defmodule AdventOfCode.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Day15

  test "init memory" do
    init = [0,3,6]

    assert init_memory(init) == %{0 => [1], 3 => [2], 6 => [3]}
  end

  @tag :skip
  test "part1 basic" do
    input = nil
    result = part1(input)

    assert result
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
