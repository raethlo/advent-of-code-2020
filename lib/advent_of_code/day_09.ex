defmodule AdventOfCode.Day09 do
  defmodule Combinations do
    @doc """
    This function lists all combinations of `num` elements from the given `list`
    """
    def combinations(list, num)
    def combinations(_list, 0), do: [[]]
    def combinations(list = [], _num), do: list
    def combinations([head | tail], num) do
      Enum.map(combinations(tail, num - 1), &[head | &1]) ++
        combinations(tail, num)
    end
  end

  defmodule XmasCrack do
    defp slice_valid?(slice) do
      [last | others] = slice |> Enum.reverse()

      {last, Combinations.combinations(others, 2) |> Enum.any?(fn [a,b] -> a + b == last end)}
    end

    def first_invalid(numbers, preamble_size)
    def first_invalid(_numbers = [], 0), do: nil
    def first_invalid(_numbers = [], _), do: nil
    def first_invalid(_numbers, 1), do: nil
    def first_invalid(numbers, preamble_size) do
      slice = numbers |> Enum.take(preamble_size + 1)

      case slice_valid?(slice) do
        {_, true} ->
          [_ | next_run] = numbers
          first_invalid(next_run, preamble_size)
        {last, false} ->
          last
      end
    end
  end

  def parse_input(input) do
    input
    |> String.split()
    |> Stream.map(&Integer.parse/1)
    |> Stream.map(fn {n, _} -> n end)
    |> Enum.to_list()
  end

  def part1(input) do
    numbers = parse_input(input)
    _first_invalid = numbers |> XmasCrack.first_invalid(26)
  end

  def part2(input) do
  end
end
