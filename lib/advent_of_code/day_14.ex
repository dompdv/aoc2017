defmodule AdventOfCode.Day14 do
  def part1(_args) do
    args = "xlqgujun"

    for i <- 0..127 do
      AdventOfCode.Day10.part2("#{args}-#{i}")
      |> String.to_integer(16)
      |> Integer.to_string(2)
      |> String.to_charlist()
      |> Enum.count(fn c -> c == ?1 end)
    end
    |> Enum.sum()
  end

  def part2(_args) do
    :ok
  end
end
