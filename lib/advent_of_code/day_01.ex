defmodule AdventOfCode.Day01 do
  import Enum

  def parse(args),
    do:
      args
      |> String.trim("\n")
      |> String.graphemes()
      |> map(&String.to_integer/1)

  def part1(args) do
    a = parse(args)

    (a ++ [List.first(a)])
    |> chunk_every(2, 1, :discard)
    |> filter(fn [a, b] -> a == b end)
    |> map(fn [a, _] -> a end)
    |> sum()
  end

  def part2(args) do
    l1 = parse(args)
    {l, h} = split(l1, div(count(l1), 2))

    zip(l1, h ++ l)
    |> filter(fn {a, b} -> a == b end)
    |> map(&elem(&1, 0))
    |> sum()
  end
end
