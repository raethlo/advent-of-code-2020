defmodule AdventOfCode.Day08 do
  defmodule Command do
    defstruct [:cmd, :op, :count, :effect]
  end

  @spec get_effect(<<_::8>>, any) :: (number -> number)
  def get_effect("+", count) do
    &(&1 + count)
  end

  def get_effect("-", count) do
    &(&1 - count)
  end

  def parse_instructions(input) do
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
      {:infinite, acc}
    else
      command = instruction_map |> Map.get(position)

      if is_nil(command) do
        {:ok, acc}
      else
        updated_visited = MapSet.put(visited, position)

        case command.cmd do
          "nop" ->
            run_instructions(instruction_map, updated_visited, position + 1, acc)

          "jmp" ->
            run_instructions(instruction_map, updated_visited, command.effect.(position), acc)

          "acc" ->
            run_instructions(instruction_map, updated_visited, position + 1, command.effect.(acc))
        end
      end
    end
  end

  def part1(input) do
    instruction_map = input |> parse_instructions

    run_instructions(instruction_map, MapSet.new(), 0, 0)
  end

  def swap_instruction(cmd) do
    case cmd do
      %Command{cmd: "jmp"} -> %Command{cmd | cmd: "nop"}
      %Command{cmd: "nop"} -> %Command{cmd | cmd: "jmp"}
    end
  end

  def part2(input) do
    instructions = input |> parse_instructions

    instructions
    |> Stream.map(fn
      {_, %Command{cmd: "acc"}} -> nil
      {index, command} -> Map.put(instructions, index, swap_instruction(command))
    end)
    |> Stream.filter(&(not is_nil(&1)))
    |> Stream.map(&run_instructions(&1, MapSet.new(), 0, 0))
    |> Stream.filter(fn {type, _} -> type == :ok end)
    |> Enum.to_list()
    |> List.first()
  end
end
