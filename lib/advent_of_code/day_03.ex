defmodule AdventOfCode.Day03 do
  @around [{-1, 1}, {0, 1}, {1, 1}, {-1, 0}, {1, 0}, {-1, -1}, {0, -1}, {1, -1}]

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
    n = 368_078
    {_, x, y} = key_points(n) |> Enum.find(fn {a, _, _} -> a == n end)
    abs(x) + abs(y)
  end

  def next({1, _, _, _, _, _}), do: {2, 1, 1, 0, :up, 2}

  def next({n, c, x, y, :up, step}) when step < 2 * c,
    do: {n + 1, c, x, y + 1, :up, step + 1}

  def next({n, c, x, y, :up, step}) when step == 2 * c,
    do: {n + 1, c, x, y + 1, :left, 1}

  def next({n, c, x, y, :left, step}) when step < 2 * c,
    do: {n + 1, c, x - 1, y, :left, step + 1}

  def next({n, c, x, y, :left, step}) when step == 2 * c,
    do: {n + 1, c, x - 1, y, :down, 1}

  def next({n, c, x, y, :down, step}) when step < 2 * c,
    do: {n + 1, c, x, y - 1, :down, step + 1}

  def next({n, c, x, y, :down, step}) when step == 2 * c,
    do: {n + 1, c, x, y - 1, :right, 1}

  def next({n, c, x, y, :right, step}) when step < 2 * c + 1,
    do: {n + 1, c, x + 1, y, :right, step + 1}

  def next({n, c, x, y, :right, step}) when step == 2 * c + 1,
    do: {n + 1, c + 1, x + 1, y, :up, 2}

  def part2(_args) do
    Enum.reduce(2..368_078, {1, 0, 0, 0, :right, 0}, fn _i, acc -> next(acc) end)

    Stream.iterate(
      {1, %{{0, 0} => 1}, next({1, 0, 0, 0, :right, 0})},
      fn {_last, storage, {_, _, x, y, _, _} = state} ->
        s = Enum.sum(for {dx, dy} <- @around, do: Map.get(storage, {x + dx, y + dy}, 0))
        {s, Map.put(storage, {x, y}, s), next(state)} |> IO.inspect()
      end
    )
    |> Stream.drop_while(fn {last, _, _} -> last < 368_078 end)
    |> Enum.take(1)
    |> List.first()
    |> elem(0)
  end
end
