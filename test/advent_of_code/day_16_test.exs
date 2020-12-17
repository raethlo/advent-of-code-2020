defmodule AdventOfCode.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Day16

  test "parse_rule" do
    parsed_rule = parse_rule("departure location: 32-174 or 190-967")
    expected = %{rule_name: "departure location", lower: 32..174, upper: 190..967}

    assert parsed_rule.rule_name == expected.rule_name
    assert parsed_rule.lower == expected.lower
    assert parsed_rule.upper == expected.upper
  end

  @tag :skip
  test "part1" do
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
