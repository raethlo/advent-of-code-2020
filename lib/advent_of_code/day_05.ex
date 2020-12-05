defmodule AdventOfCode.Day05 do
  def parse_part(part, lower_char, upper_char) do
    {parsed, _remainder} = part |> String.replace(upper_char, "1") |> String.replace(lower_char, "0") |> Integer.parse(2)

    parsed
  end

  def handle_row_part(row_part) do
    parse_part(row_part, "F", "B")
  end

  def handle_column_part(column_part) do
    parse_part(column_part, "L", "R")
  end

  def split_boarding_pass_parts(pass) do
    pass |> String.split_at(7)
  end

  def parse_boarding_pass(pass) do
    {row_part, column_part} = split_boarding_pass_parts(pass)

    row = handle_row_part(row_part)
    column = handle_column_part(column_part)

    %{"row" => row, "column" => column}
  end

  def parse_boarding_pass_2(pass) do
    {row_part, column_part} = split_boarding_pass_parts(pass)

    row = handle_row_part(row_part)
    column = handle_column_part(column_part)

    %{"row" => row, "column" => column}
  end

  @spec calculate_pass_id(map) :: number
  def calculate_pass_id(%{"row" => row, "column" => column}) do
    row * 8 + column
  end

  def calculate_pass_id(_) do
    nil
  end

  def part1(input) do
    lines = input |> String.split("\n")
    passes = lines |> Enum.map(&parse_boarding_pass/1)
    ids = passes |>  Enum.map(&calculate_pass_id/1)

    ids |> Enum.max()
  end

  def part2(input) do
    lines = input |> String.split("\n")
    passes = lines |> Enum.map(&parse_boarding_pass/1)
    ids = passes |>  Enum.map(&calculate_pass_id/1)
    _around_my_seat = ids |> Enum.sort |> Enum.chunk_every(2,1, :discard) |> Enum.filter(fn [a,b] -> b - a == 2 end)
  end
end
