defmodule AdventOfCode.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Day14

  test "Part 1 do" do
    input =
      """
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
      """
      |> String.trim_trailing()

    assert part1(input) === 165
  end

  test "read mask" do
    assert read_mask("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X") == %{one: 64, zero: 68_719_476_733}
  end

  test "apply mask" do
    mask = read_mask("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X")
    assert apply_mask(11, mask) == 73
    assert apply_mask(101, mask) == 101
    assert apply_mask(0, mask) == 64
  end

  test "expand floating bits" do
    mask = "X0X1"

    assert MapSet.new(expand_floating_bits([mask])) == MapSet.new(["1011","0001","1001","0011"])
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
