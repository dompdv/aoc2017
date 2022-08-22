defmodule AdventOfCode.Day10 do
  def parse(args),
    do: args |> String.trim() |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)

  def process(skips, list_length),
    do: process(for(i <- 0..(list_length - 1), do: i), skips, 0, 0, 0, list_length)

  def process(l, [], _, position, previous_pos, _), do: {l, position, previous_pos}

  def process(l, [s | skips], skip, position, previous_pos, list_length) do
    IO.inspect({l, s, skip, position, previous_pos})
    {low, high} = Enum.split(l, s)
    new_l = Enum.reverse(low) ++ high

    {low, high} = Enum.split(new_l, rem(skip + s, list_length))
    process(high ++ low, skips, skip + 1, position + skip + s, position, list_length)
  end

  def part1(args) do
    list_length = 256
    #    args = "3,4,1,5\n"
    {l, _, p} = parse(args) |> process(list_length)

    Enum.at(l, rem(p, list_length)) *
      Enum.at(l, rem(p + 1, list_length))
  end

  def part2(args) do
    parse(args)
  end
end
