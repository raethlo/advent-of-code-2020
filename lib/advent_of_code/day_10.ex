defmodule AdventOfCode.Day10 do
  def parse_input(input) do
    input |> String.split("\n") |> Stream.map(&Integer.parse/1) |> Stream.map(fn {n, _} -> n end) |> Enum.to_list()
  end

  def count_jolt_diff_chain(numbers) do
    sorted = [0 | numbers] |> Enum.sort(:desc)
    [first | _] = sorted
    [first+3 | sorted] |> Stream.chunk_every(2,1, :discard) |> Stream.map(fn [a,b] -> a - b end) |> Enum.frequencies()
  end

  def part1(input) do
    freqs = input |> parse_input() |> count_jolt_diff_chain()
    freqs[1] * freqs[3]
  end

  def part2(intput) do
  end
end
