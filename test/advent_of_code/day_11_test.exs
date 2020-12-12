defmodule AdventOfCode.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Day11

  @tag :skip
  test "part1" do
    input = nil
    result = part1(input)

    assert result
  end

  test "parse_seat_map" do
    input = ["#.#", "#LL", "L.L"] |> Enum.join("\n")

    seat_map = parse_seat_map(input)
    assert tuple_size(seat_map) == 3
    assert seat_map |> Tuple.to_list() |> Enum.all?(&(tuple_size(&1) == 3))
  end

  test "count values around" do
    input = """
    #.#
    #LL
    L.L
    """

    seat_map = parse_seat_map(input)
    assert count_occupied_seats_around(seat_map, 1, 1) == 3
    assert count_occupied_seats_around(seat_map, 0, 2) == 1
    assert count_occupied_seats_around(seat_map, 0, 2) == 1
  end

  test "migrate seats small" do
    input =
      """
      L.L
      LLL
      L.L
      """
      # to get rid of trailing \n
      |> String.split()
      |> Enum.join("\n")

    expected =
      """
      #.#
      ###
      #.#
      """
      # to get rid of trailing \n
      |> String.split()
      |> Enum.join("\n")

    seats = parse_seat_map(input)
    outcome = migrate_seats(seats)
    str_outcome = seat_map_to_string(outcome)
    assert str_outcome == expected
  end

  test "migrate seats bigger" do
    input =
      """
      #.LL.L#.##
      #LLLLLL.L#
      L.L.L..L..
      #LLL.LL.L#
      #.LL.LL.LL
      #.LLLL#.##
      ..L.L.....
      #LLLLLLLL#
      #.LLLLLL.L
      #.#LLLL.##
      """
      # to get rid of trailing \n
      |> String.split()
      |> Enum.join("\n")

    expected =
      """
      #.##.L#.##
      #L###LL.L#
      L.#.#..#..
      #L##.##.L#
      #.##.LL.LL
      #.###L#.##
      ..#.#.....
      #L######L#
      #.LL###L.L
      #.#L###.##
      """
      # to get rid of trailing \n
      |> String.split()
      |> Enum.join("\n")

    seats = parse_seat_map(input)
    outcome = migrate_seats(seats)
    str_outcome = seat_map_to_string(outcome)
  end

  test "tick counts final state" do
    input = """
    #.#
    #LL
    L.L
    """

    seat_map = parse_seat_map(input)
    tick(seat_map, seat_map) == 3
  end

  # @tag :skip
  test "tick morphs state correctly" do
    input =
      """
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
      """
      |> String.split()
      |> Enum.join("\n")

    expected_end_state =
      """
      #.#L.L#.##
      #LLL#LL.L#
      L.#.L..#..
      #L##.##.L#
      #.#L.LL.LL
      #.#L#L#.##
      ..L.L.....
      #L#L##L#L#
      #.LLLLLL.L
      #.#L#L#.##
      """
      |> String.split()
      |> Enum.join("\n")

    input_seat_map = parse_seat_map(input)

    x = tick(input_seat_map)
    {actual_end_state, occupied_count} = x
    str_end_state = seat_map_to_string(actual_end_state)

    assert str_end_state == expected_end_state
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result

    a = fn
      x, y when x != y -> "diff"
      x, x when x == x -> "blanb"
      _, _ -> "whatev"
    end
  end
end
