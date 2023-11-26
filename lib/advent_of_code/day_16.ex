defmodule AdventOfCode.Day16 do
  def string_to_integer(s), do: (s |> String.first() |> to_charlist() |> hd()) - ?a

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(fn x ->
      case String.trim(x) do
        "s" <> n ->
          {:spin, String.to_integer(n)}

        "x" <> e ->
          [a, b] = String.split(e, "/")
          {:exchange, String.to_integer(a), String.to_integer(b)}

        "p" <> p ->
          [a, b] = String.split(p, "/")
          {:partner, string_to_integer(a), string_to_integer(b)}
      end
    end)
  end

  def print_s({n, low, high, mapping}) do
    reverse = for {i, j} <- mapping, into: %{}, do: {j, i}
    maps = for(i <- low..high, do: reverse[i] + ?a) |> to_string()
    IO.puts("low: #{low}, high: #{high} mapping: #{maps}")
    {n, low, high, mapping}
  end

  def inital_state(n) do
    # Size, low index, high index, map
    {n, 0, n - 1, for(i <- 0..(n - 1), into: %{}, do: {i, i})}
  end

  def next_state({:spin, x}, {n, low, high, mapping}) do
    new_mapping =
      for {i, j} <- mapping do
        if j <= high - x, do: {i, j}, else: {i, j - n}
      end
      |> Map.new()

    {n, low - x, high - x, new_mapping}
  end

  def next_state({:exchange, a, b}, {n, low, high, mapping}) do
    new_mapping =
      for {i, j} <- mapping do
        cond do
          j == a + low -> {i, b + low}
          j == b + low -> {i, a + low}
          true -> {i, j}
        end
      end
      |> Map.new()

    {n, low, high, new_mapping}
  end

  def next_state({:partner, a, b}, {n, low, high, mapping}) do
    new_mapping =
      mapping |> Map.put(a, mapping[b]) |> Map.put(b, mapping[a])

    {n, low, high, new_mapping}
  end

  def one_dance(steps, starting_point) do
    steps
    |> Enum.reduce(starting_point, &next_state/2)
  end

  def part1(args) do
    n_dancers = 16

    args
    |> parse_input()
    |> one_dance(inital_state(n_dancers))
    |> print_s()

    :ok
  end

  def renormalize({_n, low, _high, mapping}) do
    for {i, j} <- mapping, into: %{}, do: {i, j - low}
  end

  def apply_permutation(mapping, permutation) do
    for {i, j} <- mapping, into: %{}, do: {i, permutation[j]}
  end

  def print_p(mapping) do
    reverse = for {i, j} <- mapping, into: %{}, do: {j, i}
    maps = for(i <- 0..(map_size(reverse) - 1), do: reverse[i] + ?a) |> to_string()
    IO.puts("mapping: #{maps}")
    mapping
  end

  def part2(args) do
    #    args = "s1,x3/4,pe/b"
    args = List.duplicate("s1", 5) |> Enum.join(",")
    n_dancers = 5

    permutation =
      args
      |> parse_input()
      |> one_dance(inital_state(n_dancers))
      |> renormalize()
      |> print_p()
      |> IO.inspect(label: "permutation")

    initial_order = for(i <- 0..(n_dancers - 1), into: %{}, do: {i, i})

    loop_size =
      Enum.reduce_while(
        1..1_000_000_000,
        initial_order |> print_p(),
        fn i, state ->
          new_state = state |> apply_permutation(permutation) |> print_p()
          if new_state == initial_order, do: {:halt, i}, else: {:cont, new_state}
        end
      )
      |> IO.inspect(label: "loop")

    Enum.reduce(
      1..rem(1_000_000_000, loop_size - 1),
      initial_order,
      fn i, state ->
        IO.inspect(i)
        state |> print_p() |> apply_permutation(permutation)
      end
    )
    |> print_p()

    :ok
  end
end
