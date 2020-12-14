defmodule AdventOfCode.Day14 do
  use Bitwise

  def read_mask(string) do
    %{
      zero: string |> String.replace("X", "1") |> String.to_integer(2),
      one: string |> String.replace("X", "0") |> String.to_integer(2)
    }
  end


  def apply_mask(number, %{zero: zero_mask, one: one_mask}) do
    (number ||| one_mask) &&& zero_mask
  end

  def part1(args) do
  end

  def part2(args) do
  end
end
