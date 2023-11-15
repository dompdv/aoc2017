defmodule AdventOfCode.Day10 do
  def parse(args),
    do: args |> String.trim() |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)

  def process(l, position, length, skip, list_length) do
    for i <- 0..(length - 1), into: %{} do
      {rem(position + i, list_length), rem(position + length - i, list_length)}
    end
  end

  def part1(args) do
    list_length = 5
    initial_list = for i <- 0..(list_length - 1), do: i
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
