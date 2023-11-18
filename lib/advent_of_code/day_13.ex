defmodule AdventOfCode.Day13 do
  import Enum

  def list_to_integers(list), do: list |> map(&String.to_integer/1)

  def parse(args) do
    args
    |> String.split("\n", trim: true)
    |> map(fn line ->
      line |> String.split(": ", trim: true) |> list_to_integers() |> List.to_tuple()
    end)
    |> Map.new()
  end

  def part1(args) do
    args
    |> parse()
    |> Enum.reduce(0, fn {i, m}, score ->
      score +
        if rem(i, 2 * (m - 1)) == 0,
          do: i * m,
          else: 0
    end)
  end

  def caught?(fw, delay) do
    Enum.reduce_while(fw, false, fn {i, m}, _ ->
      if rem(delay + i, 2 * (m - 1)) == 0,
        do: {:halt, true},
        else: {:cont, false}
    end)
  end

  def while_caught(fw, delay) do
    if caught?(fw, delay),
      do: while_caught(fw, delay + 1),
      else: delay
  end

  def part2(args), do: args |> parse() |> while_caught(0)
end
