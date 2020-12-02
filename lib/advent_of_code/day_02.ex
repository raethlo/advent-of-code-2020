defmodule AdventOfCode.Day02 do

  @spec part1(binary) :: non_neg_integer
  def part1(input) do
    lines = input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " "))

    valid_password_count = lines |> Enum.count(fn x ->
      [counts, letter_def, pass] = x
      actual_letter = String.first(letter_def)
      [lower, upper] = String.split(counts, "-") |> Enum.map(&Integer.parse/1) |> Enum.map(fn {a,_} -> a end)
      count =  Enum.count(String.codepoints(pass), fn x -> x == actual_letter end)

      (lower <= count) and (count <= upper)
    end)
  end

  def part2(args) do
  end
end
