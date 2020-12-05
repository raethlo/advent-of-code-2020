defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05

  test "part1 parse boarding pass" do
    Enum.each([
      {"BFFFBBFRRR", %{"row" => 70, "column" => 7}},
      {"FFFBBBFRRR", %{"row" => 14, "column" => 7}},
      {"BBFFBBFRLL", %{"row" => 102, "column" => 4}},
    ], fn {pass, result} ->
      assert parse_boarding_pass(pass) == result
    end)
  end

  test "part1 calculate id" do
    Enum.each([
      {"BFFFBBFRRR", 567},
      {"FFFBBBFRRR", 119},
      {"BBFFBBFRLL", 820},
    ], fn {pass, result} ->

      assert calculate_pass_id(parse_boarding_pass(pass))
    end)
  end

  test "handle column part" do
    assert handle_column_part("RRR") == 7
    assert handle_column_part("RRL") == 6
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
