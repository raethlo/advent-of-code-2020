defmodule AdventOfCode.Day08 do
  defmodule Command do
    defstruct [:cmd, :op, :count, :effect]
  end

  def get_effect("+", count) do
    &(&1 + count)
  end

  def get_effect("-", count) do
    &(&1 - count)
  end

  @spec parse_intstructions(binary) :: [any]
  def parse_intstructions(input) do
    input
    |> String.split("\n")
    |> Stream.map(&String.split/1)
    |> Stream.map(fn [cmd, op_str] ->
      {op, count_str} = String.split_at(op_str, 1)
      {count, _} = Integer.parse(count_str)

      effect = get_effect(op, count)

      %Command{cmd: cmd, op: op, count: count, effect: effect}
    end)
    |> Stream.with_index()
    |> Enum.into(%{}, fn {command, index} -> {index, command} end)
  end

  @spec run_instructions(any, any, any, any) :: any
  def run_instructions(instruction_map, visited, position, acc) do
    if MapSet.member?(visited, position) do
      acc
    else
      command = instruction_map |> Map.get(position)

      updated_visited = MapSet.put(visited, position)

      case command.cmd do
        "nop" -> run_instructions(instruction_map, updated_visited, position + 1, acc)
        "jmp" -> run_instructions(instruction_map, updated_visited, command.effect.(position), acc)
        "acc" -> run_instructions(instruction_map, updated_visited, position + 1, command.effect.(acc))
      end
    end
  end

  @spec part1(binary) :: :ok | {:error, :no_iex | :refused}
  def part1(input) do
    instruction_map = input |> parse_intstructions

    run_instructions(instruction_map, MapSet.new(), 0, 0)
  end

  def part2(input) do
  end
end
