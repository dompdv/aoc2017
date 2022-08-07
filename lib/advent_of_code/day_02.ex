defmodule AdventOfCode.Day02 do
  import Enum

  def parse(args),
    do:
      args
      |> String.split("\n", trim: true)
      |> map(fn line -> String.split(line, "\t") |> map(&String.to_integer/1) end)

  def part1(args) do
    parse(args)
    |> map(&min_max/1)
    |> map(&(elem(&1, 1) - elem(&1, 0)))
    |> sum()
  end

  def checksum(a, b) do
    {mi, ma} = min_max([a, b])
    if rem(ma, mi) == 0, do: div(ma, mi), else: 0
  end

  def part2(args) do
    parse(args)
    |> map(fn line ->
      for(
        {n1, i1} <- with_index(line),
        {n2, i2} <- with_index(line),
        i1 < i2,
        do: checksum(n1, n2)
      )
      |> sum()
    end)
    |> sum()
  end
end
