defmodule AdventOfCode.Day16 do
  def parse_rules(rule_list_str) do
    rule_list_str |> String.split("\n") |> Enum.map(&parse_rule/1)
  end

  def parse_tickets(tickets_list_str) do
    tickets_list_str |> String.split("\n") |> Enum.split(1) |> elem(1) |> Enum.map(fn row ->
      row |> String.split(",") |> Enum.map(&String.to_integer/1)
    end)
  end

  def parse_rule(rule_row) do
    %{"rule_name" => rule_name, "upper" => upper, "lower" => lower, "op" => op} = Regex.named_captures(~r/(?<rule_name>.*): (?<lower>.*) (?<op>.*) (?<upper>.*)/, rule_row)

    [upper_left, upper_right] = upper |> String.split("-") |> Enum.map(&String.to_integer/1)
    [lower_left, lower_right] = lower |> String.split("-") |> Enum.map(&String.to_integer/1)

    %{rule_name: rule_name, upper: upper_left..upper_right, lower: lower_left..lower_right, op: op}
  end

  def get_invalid_fields(ticket, rules) do
    Enum.filter(ticket, fn n ->
      not Enum.any?(rules, fn %{upper: upper, lower: lower} ->
        n in upper or n in lower
      end)
    end)
  end

  @spec part1(binary) :: :ok | {:error, :no_iex | :refused}
  def part1(input) do
    [rules_str, _my_ticket_str, nearby_tickets_str] = input |> String.split("\n\n")

    rules = parse_rules(rules_str)
    tickets = parse_tickets(nearby_tickets_str)

    error_rate = tickets |> Enum.reduce(0, fn ticket, acc ->
      acc + Enum.sum(get_invalid_fields(ticket, rules))
    end)
  end

  def part2(args) do
  end
end
