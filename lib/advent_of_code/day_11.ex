defmodule AdventOfCode.Day11 do
  def move("nw", {q, r, s}), do: {q, r - 1, s + 1}
  def move("n", {q, r, s}), do: {q + 1, r - 1, s}
  def move("ne", {q, r, s}), do: {q + 1, r, s - 1}
  def move("sw", {q, r, s}), do: {q - 1, r, s + 1}
  def move("s", {q, r, s}), do: {q - 1, r + 1, s}
  def move("se", {q, r, s}), do: {q, r + 1, s - 1}

  def part1(args) do
    {q, r, s} =
      args
      |> String.trim()
      |> String.split(",", trim: true)
      |> Enum.reduce({0, 0, 0}, &move/2)
      |> IO.inspect()

    div(abs(q) + abs(r) + abs(s), 2)
  end

  def part2(_args) do
    :ok
  end
end
