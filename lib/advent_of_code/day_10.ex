defmodule AdventOfCode.Day10 do
  def parse(args),
    do: args |> String.trim() |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)

  def reverse_sublist(l, position, length, skip, list_length) do
    last_pos = position + length - 1
    last_index = rem(last_pos, list_length)
    overflow = last_pos >= list_length

    for i <- 0..(list_length - 1), into: %{} do
      cond do
        overflow and (i <= last_index or i >= position) ->
          {i, l[rem(last_pos - (i - position), list_length)]}

        not overflow and (i >= position and i <= last_index) ->
          {i, l[rem(last_pos - (i - position), list_length)]}

        true ->
          {i, l[i]}
      end
    end
  end

  def process(l, position, length, skip, list_length) do
    reverse_sublist(l, position, length, skip, list_length)
  end

  def part1(args) do
    list_length = 5
    initial_list = for i <- 0..(list_length - 1), into: %{}, do: {i, i}
    args = "3,4,1,5\n"

    process(initial_list, 0, 3, 0, list_length)

    #    parse(args)
    #    |> Enum.reduce({initial_list, 0}, fn length, {current_list, current_position, skip} ->
    #      process(current_list, current_position, length, skip, list_length)
    #    end)

    #
    # Enum.at(l, rem(p, list_length)) *
    #  Enum.at(l, rem(p + 1, list_length))
  end

  def part2(args) do
    parse(args)
  end
end
