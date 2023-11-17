defmodule AdventOfCode.Day10 do
  def reverse_sublist(l, position, length, skip, list_length) do
    last_pos = position + length - 1
    last_index = rem(last_pos, list_length)
    overflow = last_pos >= list_length

    for i <- 0..(list_length - 1), into: %{} do
      to_be_swapped =
        (overflow and (i <= last_index or i >= position)) or
          (not overflow and (i >= position and i <= last_index))

      if to_be_swapped,
        do: {i, l[rem(last_pos - (i - position), list_length)]},
        else: {i, l[i]}
    end
  end

  def one_round(lengths, l, position, skip, list_length) do
    lengths
    |> Enum.reduce(
      {l, position, skip},
      fn length, {current_list, current_position, skip} ->
        {reverse_sublist(current_list, current_position, length, skip, list_length),
         rem(current_position + length + skip, list_length), skip + 1}
      end
    )
  end

  def part1(args) do
    list_length = 256
    initial_list = for i <- 0..(list_length - 1), into: %{}, do: {i, i}

    args
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> one_round(initial_list, 0, 0, list_length)
    |> elem(0)
    |> then(fn d -> d[0] * d[1] end)
  end

  def part2(args) do
    list_length = 256
    initial_list = for i <- 0..(list_length - 1), into: %{}, do: {i, i}

    sequence =
      args
      |> String.trim()
      |> String.to_charlist()
      |> then(fn l -> l ++ [17, 31, 73, 47, 23] end)

    Enum.reduce(1..64, {initial_list, 0, 0}, fn _, {list, position, skip} ->
      one_round(sequence, list, position, skip, list_length)
    end)
    |> elem(0)
    |> then(fn l -> for i <- 0..(list_length - 1), do: l[i] end)
    |> Enum.chunk_every(16)
    |> Enum.map(fn block -> Enum.reduce(block, &Bitwise.bxor/2) end)
    |> Enum.map(fn n -> Integer.to_string(n, 16) end)
    |> Enum.join()
  end
end
