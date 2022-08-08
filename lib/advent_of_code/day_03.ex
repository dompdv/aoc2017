defmodule AdventOfCode.Day03 do
  def find_circle(a) do
    c = trunc(:math.sqrt(a))
    squared = if rem(c, 2) == 1, do: c, else: c - 1
    if squared * squared == a, do: div(c - 1, 2), else: div(squared - 1, 2) + 1
  end

  def key_points(a) do
    circle = find_circle(a)
    side = 2 * circle + 1
    previous = (2 * circle - 1) * (2 * circle - 1)

    acc =
      Enum.reduce(
        1..(side - 2),
        [{previous + 1, circle, -circle + 1}],
        fn
          _e, [{n, x, y} | _r] = acc ->
            [{n + 1, x, y + 1} | acc]
        end
      )

    acc =
      Enum.reduce(
        1..(side - 1),
        acc,
        fn
          _e, [{n, x, y} | _r] = acc ->
            [{n + 1, x - 1, y} | acc]
        end
      )

    acc =
      Enum.reduce(
        1..(side - 1),
        acc,
        fn
          _e, [{n, x, y} | _r] = acc ->
            [{n + 1, x, y - 1} | acc]
        end
      )

    Enum.reduce(
      1..(side - 1),
      acc,
      fn
        _e, [{n, x, y} | _r] = acc ->
          [{n + 1, x + 1, y} | acc]
      end
    )
  end

  def part1(_args) do
    #    for i <- 1..26, do: {i, key_points(i)}
    n = 368_078
    {_, x, y} = key_points(n) |> Enum.find(fn {a, _, _} -> a == n end)
    abs(x) + abs(y)
  end

  def part2(_args) do
  end
end
