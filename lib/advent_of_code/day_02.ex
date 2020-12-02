defmodule AdventOfCode.Day02 do

  @spec parse_lines(binary) :: [binary,...]
  def parse_lines(input) do
    input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " "))
  end

  @spec first_validity_condition([binary, ...]) :: boolean
  def first_validity_condition(line) do
    [counts, letter_def, pass] = line
      actual_letter = String.first(letter_def)
      [lower, upper] = String.split(counts, "-") |> Enum.map(&Integer.parse/1) |> Enum.map(fn {a,_} -> a end)
      count =  Enum.count(String.codepoints(pass), fn x -> x == actual_letter end)

      (lower <= count) and (count <= upper)
  end

  @spec second_validity_condition([binary, ...]) :: boolean
  def second_validity_condition(line) do
    [counts, letter_def, pass] = line
    actual_letter = String.first(letter_def)
    [lower, upper] = String.split(counts, "-") |> Enum.map(&Integer.parse/1) |> Enum.map(fn {a,_} -> a end)
    codepoints = String.codepoints(pass)

    first = Enum.at(codepoints, lower-1) == actual_letter
    second = Enum.at(codepoints, upper-1) == actual_letter

    first != second
  end

  @spec part1(binary) :: non_neg_integer
  def part1(input) do
    parse_lines(input) |> Enum.count(&first_validity_condition/1)
  end

  def part2(input) do
    parse_lines(input) |> Enum.count(&second_validity_condition/1)
  end
end
