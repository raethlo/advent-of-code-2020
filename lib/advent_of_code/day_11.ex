defmodule AdventOfCode.Day11 do
  @spec parse_seat_map(binary) :: tuple
  def parse_seat_map(input) do
    input |> String.splitter(["\n"]) |> Stream.map(&String.codepoints/1) |> Stream.map(&List.to_tuple/1) |> Enum.to_list |> List.to_tuple
  end

  def safe_elem(tuple, at, default \\ nil) do
    try do
      tuple |> elem(at)
    rescue ArgumentError -> default
    end
  end

  def seat_at(seat_map, x, y) do
    seat_map |> safe_elem(y, {}) |> safe_elem(x, ".")
  end

  def occupied?(seat_map, x, y) do
    seat_at(seat_map, x, y) == "#"
  end

  def count_occupied_seats_around(seat_map, x, y) do
    -1..1 |> Enum.flat_map(fn y_i ->
      Enum.map(-1..1, fn
        x_i -> if occupied?(seat_map, x + x_i, y + y_i), do: 1, else: 0
      end)
    end) |> Enum.sum()
  end

  def seat_map_to_string(seat_map) do
    seat_map |> Tuple.to_list() |> Stream.map(& Tuple.to_list(&1) |> Enum.join()) |> Enum.join("\n")
  end

  def migrate_seats(seat_map) do
    seat_map_height = tuple_size(seat_map)

    Enum.reduce(seat_map_height-1..0, {}, fn y_i, acc ->
      row = elem(seat_map, y_i)
      row_width = tuple_size(row)
      new_row = Enum.reduce(row_width-1..0, {}, fn x_i, acc_in ->
        new_seat_state = case seat_at(seat_map, x_i, y_i) do
          "#" ->
            if count_occupied_seats_around(seat_map, x_i, y_i) > 4, do: "L", else: "#"
          "L" ->
            if count_occupied_seats_around(seat_map, x_i, y_i) == 0, do: "#", else: "L"
          "." -> "."
        end

        Tuple.insert_at(acc_in, 0, new_seat_state)
      end)


      Tuple.insert_at(acc, 0, new_row)
    end)
  end

  def tick(seat_map, acc \\ {})
  def tick(same, same) do
    occupied_seat_count = same |> Tuple.to_list() |> Stream.map(fn row -> row |> Tuple.to_list |> Enum.count(& &1 == "#") end) |> Enum.sum

    {same, occupied_seat_count}
  end
  def tick(seat_map, _) do
    tick(migrate_seats(seat_map), seat_map)
  end


  def part1(input) do
    seat_map = parse_seat_map(input)
    {_last_seat_map, occupied_count} = tick(seat_map, {})

    occupied_count
  end

  def part2(args) do
  end
end
