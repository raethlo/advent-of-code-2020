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

    # require IEx; IEx.pry()

    Enum.all?(required, fn key -> pass |> Map.has_key?(key) end) and Enum.all?(required, fn key -> passport_part_valid?(key, Map.get(pass, key)) end)
  end

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
    number_between?(value, 2010, 2020)
  end


  def passport_part_valid?("eyr", value) do
    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    number_between?(value, 2020, 2030)
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

  def passport_part_valid?("hcl", value) do
    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    String.match?(value, ~r/^#[0-9a-f]{6}$/)
  end

  def passport_part_valid?("ecl", value) do
    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    String.match?(value, ~r/(amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth)/)
  end

  def passport_part_valid?("pid", value) do
    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    String.match?(value, ~r/^[0-9]{9}$/)
  end

  def passport_part_valid?(_, _) do
    false
  end

  def part1(input) do
    parse_passport_input(input) |> Enum.count(&passport_valid?/1)
  end

  def part2(input) do
    pwds = parse_passport_input(input)
    pwds |> Enum.count(&passport_valid_part2?/1)
  end
end
