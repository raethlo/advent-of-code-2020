defmodule AdventOfCode.Day04 do
  def parse_passport_input(input_string) do
      input_string
      |> String.split("\n\n")
      |> Enum.map(fn row ->
        row
        |> String.split()
        |> Enum.map(&String.split(&1, ":"))
        |> Enum.into(%{}, fn [k, v] -> {k, v} end)
      end)
  end

  @spec passport_valid?(map) :: boolean
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
      "pid"
      # (Country ID) - ignored for part 1
      # "cid"
    ]

    required |> Enum.all?(fn x -> pass |> Map.has_key?(x) end)
  end

  @spec passport_valid_part2?(map) :: boolean
  def passport_valid_part2?(pass) do
    required = [
      # (Birth Year)
      "byr" ,
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
    ]

    required |> Enum.all?(fn x -> pass |> Map.has_key?(x) and passport_part_valid?(x, Map.get(pass, x)) end)
  end

  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  # cid (Country ID) - ignored, missing or not

  defp number_between?(value, lower_bound, upper_bound) do
    case Integer.parse(value) do
      :error -> false
      {parsed_num, _} -> parsed_num >= lower_bound and parsed_num <= upper_bound
    end
  end

  def passport_part_valid?("byr", value) do
    # byr (Birth Year) - four digits; at least 1920 and at most 2002.
    number_between?(value, 1920, 2002)
  end


  def passport_part_valid?("iyr", value) do
    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    number_between?(value, 1920, 2020)
  end


  def passport_part_valid?("eyr", value) do
    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    number_between?(value, 1920, 2020)
  end


  def passport_part_valid?("hgt", value) do
    # hgt (Height) - a number followed by either cm or in:
    # If cm, the number must be at least 150 and at most 193.
    # If in, the number must be at least 59 and at most 76.
    cpt = Regex.named_captures(~r/(?<h>\d+)(?<unit>(cm)|(in))/, value)

    case cpt do
      %{"h" => h, "unit" => "cm" } -> number_between?(h, 150, 193)
      %{"h" => h, "unit" => "in" } -> number_between?(h, 59, 76)
      _ -> false
    end
  end

  def part1(input) do
    parse_passport_input(input) |> Enum.count(&passport_valid?/1)
  end

  def part2(input) do
    parse_passport_input(input) |> Enum.count(&passport_valid_part2?/1)
  end
end
