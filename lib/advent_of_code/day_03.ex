defmodule AdventOfCode.Day03 do

  @spec parse_lines(binary) :: {non_neg_integer, map}
  def parse_lines(input) do
    # Maps a 2d array input "slope map" into a Map index -> index -> character

    reverse_tuple = fn {a,b} -> {b,a} end # A helper to pass the output of Enum.with_index to Enum.into

    rows = input
      |> String.split("\n", trim: true)

    width = rows |> List.first() |> String.length()

    map = rows
      |> Enum.with_index()
      |> Enum.into(%{}, fn {row, index} -> {
          index,
          row |> String.codepoints() |> Enum.with_index() |> Enum.into(%{}, reverse_tuple)
        }
      end)

    {width, map}
  end

  @spec count_obstacles(
          {integer, nil | maybe_improper_list | map},
          binary,
          integer,
          integer,
          integer,
          integer
        ) :: non_neg_integer
  def count_obstacles({width, map}, what, x, y, x_inc, y_inc) do
    next_x = rem(x + x_inc, width)
    next_y = y + y_inc

    case obstacle_at?(map, what, x, y) do
      nil -> 0
      false -> 0 + count_obstacles({width, map}, what, next_x, next_y, x_inc, y_inc)
      true ->  1 + count_obstacles({width, map}, what, next_x, next_y, x_inc, y_inc)
    end
  end



  @spec obstacle_at?(map, binary, integer, integer) :: false | nil | true
  def obstacle_at?(lines, obstacle, x, y) do
    if is_nil(lines[y]) do
      nil
    else
      case lines[y][x] do
        nil -> nil
        ^obstacle -> true
        _ -> false
      end
    end
  end

  @spec part1(binary) :: non_neg_integer
  def part1(input) do
    {width, map} = parse_lines(input)

    count_obstacles({width, map}, "#", 0, 0, 3, 1)
  end

  def part2(input) do
    {width, map} = parse_lines(input)

    steps = [{1,1}, {3,1}, {5,1}, {7,1}, {1, 2}]

    steps |> Enum.reduce(1, fn {x, y}, acc -> acc * count_obstacles({width, map}, "#", 0, 0, x, y) end)
  end
end
