defmodule AdventOfCode.Day11 do
  def safe_elem(tuple, at, default \\ nil) do
    try do
      tuple |> elem(at)
    rescue ArgumentError -> default
    end
  end

  def around(tuple, pos, w \\ 1, default \\ nil) do
    -w..w |> Enum.map(&(safe_elem(tuple, &1 + pos, default)))
  end


  @spec count_occupied_seats_around(any, any, any) ::
          (any, any -> {:halted, any} | {:suspended, any, (any -> any)})
  def count_occupied_seats_around(seat_map, x, y) do
    # Enum.flat_map_reduce(-1..1, fn , acc ->
    #   Enum.map(-1..1, fn acc, x_i ->
    #     case seat_map |> safe_elem(y_i + y, {}) |> safe_elem(x_i + x, ".") do
    #       "#" -> 1
    #       _ -> 0
    #     end
    #   end) |> Enum.sum()
    # end)
  end

  @spec part1(binary) :: :ok | {:error, :no_iex | :refused}
  def part1(input) do
    x = input |> String.splitter(["\n"]) |> Stream.map(&String.codepoints/1) |> Stream.map(&List.to_tuple/1) |> Enum.to_list |> List.to_tuple
    require IEx; IEx.pry()
  end

  def part2(args) do
  end
end
