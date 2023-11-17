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

  def one_round(l, lengths, position, skip, list_length) do
    Enum.reduce(lengths, {l, position, skip}, fn length, {current_list, current_position, skip} ->
      {reverse_sublist(current_list, current_position, length, skip, list_length),
       rem(current_position + length + skip, list_length), skip + 1}
    end)
  end

  def part1(args) do
    list_length = 256
    initial_list = for i <- 0..(list_length - 1), into: %{}, do: {i, i}
    #    args = "3,4,1,5\n"
    args
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({initial_list, 0, 0}, fn length, {current_list, current_position, skip} ->
      {reverse_sublist(current_list, current_position, length, skip, list_length),
       rem(current_position + length + skip, list_length), skip + 1}
    end)
    |> elem(0)
    |> then(fn d -> d[0] * d[1] end)
  end

  def part2(args) do
    args = "3,4,1,5\n"
    args = "1,2,3\n"

    args
    |> String.trim()
    |> String.to_charlist()
    |> then(fn l -> l ++ [17, 31, 73, 47, 23] end)
  end
end
