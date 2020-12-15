defmodule AdventOfCode.Day15 do

  def handle_turn(number, turn, memory) do
    case Map.get(memory, number) do
      nil ->
        0
      [last_mention] ->
        turn - last_mention
      [last_mention, mention_before] ->
        last_mention - mention_before
    end
  end

  def add_to_memory(memory, number, turn) do
    case Map.get(memory, number) do
      nil -> Map.put(memory, number, [turn])
      [last | _] -> Map.put(memory, number, [turn, last])
    end
  end

  def cycle(last_number, turn, memory, stop_turn \\ 2020)
  def cycle(last_number, turn, _, turn), do: last_number
  def cycle(last_number, last_turn, memory, stop_turn) do
    new_number = handle_turn(last_number, last_turn, memory)
    new_turn = last_turn + 1

    cycle(new_number, new_turn, add_to_memory(memory, new_number, new_turn), stop_turn)
  end

  def init_memory(init_sequence) do
    init_sequence |> Enum.with_index() |> Enum.reduce(%{}, fn {value, i}, acc -> Map.put(acc, value, [i+1]) end)
  end

  def part1(args) do
    input = [19,0,5,1,10,13]

    memory = init_memory(input)
    require IEx;IEx.pry
  end

  def part2(args) do
  end
end
