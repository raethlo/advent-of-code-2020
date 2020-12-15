defmodule AdventOfCode.Day14 do
  use Bitwise

  def permutations([]), do: [[]]
  def permutations(list), do: for elem <- list, rest <- permutations(list--[elem]), do: [elem|rest]

  def consume(instruction_list, mask, acc)
  def consume([], _, acc) do
    acc
  end
  def consume([h | t], mask, acc) do
    [instr, value] = String.split(h, " = ")

    case String.slice(instr, 0, 3) do
      "mas" ->
        new_mask = read_mask(value)
        consume(t, new_mask, acc)

      "mem" ->
        %{"mem" => mem} = Regex.named_captures(~r/mem\[(?<mem>\d+)\]/, instr)

        masked_value = apply_mask(String.to_integer(value), mask)
        new_acc = Map.put(acc, String.to_integer(mem), masked_value)

        consume(t, mask, new_acc)
    end
  end

  def read_mask(string) do
    %{
      zero: string |> String.replace("X", "1") |> String.to_integer(2),
      one: string |> String.replace("X", "0") |> String.to_integer(2)
    }
  end

  def expand_floating_bits(masks, acc \\ [])
  def expand_floating_bits([], acc), do: acc
  def expand_floating_bits([h | t], acc)  do

    if String.contains?(h, "X") do
      expand_floating_bits([String.replace(h, "X", "1", global: false), String.replace(h, "X", "0", global: false) | t ], acc)
    else
      IO.puts h
      expand_floating_bits(t, [h | acc])
    end
  end

  def apply_mask(number, %{zero: zero_mask, one: one_mask}) do
    (number ||| one_mask) &&& zero_mask
  end


  def apply_mask_2(number, mask_str) do
    mask = mask_str |> String.to_integer(2)

    number ||| mask
  end


  def consume_2(instruction_list, mask, acc)
  def consume_2([], _, acc) do
    acc
  end
  def consume_2([h | t], mask, acc) do
    [instr, value] = String.split(h, " = ")

    case String.slice(instr, 0, 3) do
      "mas" ->
        consume_2(t, value, acc)
      "mem" ->
        %{"mem" => mem} = Regex.named_captures(~r/mem\[(?<mem>\d+)\]/, instr)
        value_number = String.to_integer(value)
        mem_number = String.to_integer(mem)

        new_acc = expand_floating_bits([mask]) |> Enum.reduce(acc, fn mask_option, acc_in ->
          masked_mem = apply_mask_2(mem_number, mask_option)

          Map.put(acc_in, masked_mem, value_number)
        end)

        consume_2(t, mask, new_acc)
    end
  end

  def part1(input) do
    instruction_list = String.split(input, "\n")
    memory = consume(instruction_list, "", %{})
    memory |> Map.values |> Enum.filter(& &1 > 0) |> Enum.sum
  end

  def part2(input) do
    instruction_list = String.split(input, "\n")
    memory = consume_2(instruction_list, "", %{})
    memory |> Map.values |> Enum.sum
  end
end
