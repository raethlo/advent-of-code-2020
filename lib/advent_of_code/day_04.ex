defmodule AdventOfCode.Day04 do
  def passport_valid?(pass) do
    required = [
      # (Birth Year)
      "byr",
      # (Issue Year)
      "iyr",
      # (Expiration Year)
      "eyr",
      # (Height)
      "hgt",
      # (Hair Color)
      "hcl",
      # (Eye Color)
      "ecl",
      # (Passport ID)
      "pid",
      # (Country ID) - ignored for part 1
      # "cid"
    ]

    required |> Enum.all?(fn x -> pass |> Map.has_key?(x) end)
  end

  def part1(input) do
    passports =
      input
      |> String.split("\n\n")
      |> Enum.map(fn row ->
        row
        |> String.split()
        |> Enum.map(&String.split(&1, ":"))
        |> Enum.into(%{}, fn [k, v] -> {k, v} end)
      end)

    passports |> Enum.count(&passport_valid?/1)
  end

  def part2(args) do
  end
end
