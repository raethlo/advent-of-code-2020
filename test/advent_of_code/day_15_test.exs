defmodule AdventOfCode.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Day15

  test "init memory" do
    init = [0,3,6]

    assert init_memory(init) == %{0 => [1], 3 => [2], 6 => [3]}
  end

  test "part1 basic" do
    init = [0,3,6]
    memory = init_memory(init)

    assert cycle(6, 3, memory, 10) == 0
  end

  test "part 1 more complex" do
    assert cycle(2, 3, init_memory([1,3,2])) == 1
    assert cycle(3, 3, init_memory([2,1,3])) == 10
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
