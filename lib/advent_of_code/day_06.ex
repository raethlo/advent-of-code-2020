defmodule AdventOfCode.Day06 do
  def part1(input) do
    input
    |> String.split("\n\n")
    |> Stream.map(fn group ->
      group
      |> String.replace("\n", "", global: true)
      |> String.graphemes()
      |> Stream.uniq
      |> Enum.count
    end)
    |> Enum.sum
  end

  def part2(input) do
    input
      |> String.split("\n\n")
      |> Stream.map(&String.split/1)
      |> Stream.map(fn parts ->
        parts
        |> Stream.map(&String.graphemes/1)
        |> Stream.map(&MapSet.new/1)
        |> Enum.reduce(fn x, acc -> MapSet.intersection(x, acc) end)
        |> Enum.count
      end)
      |> Enum.sum
  end
end
