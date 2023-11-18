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

  def init(fw) do
    {fw, for({i, _} <- fw, into: %{}, do: {i, {0, 1}}), 0}
  end

  def tick({fw, positions, time}) do
    new_positions =
      for {i, {p, v}} <- positions, into: %{} do
        cond do
          v == 1 and p == fw[i] - 1 -> {i, {p - 1, -1}}
          v == -1 and p == 0 -> {i, {p + 1, 1}}
          true -> {i, {p + v, v}}
        end
      end

    {fw, new_positions, time + 1}
  end

  def print_fw({fw, positions, time} = state) do
    IO.puts("Time: #{time}")

    for i <- 0..get_maxl(state) do
      if Map.has_key?(fw, i) do
        IO.puts("#{i}: #{fw[i]} | #{elem(positions[i], 0)} | #{elem(positions[i], 1)}")
      else
        IO.puts("#{i}: ...")
      end
    end

    state
  end

  def collide_score({fw, state, _time}, layer) do
    cond do
      not Map.has_key?(fw, layer) -> 0
      elem(state[layer], 0) == 0 -> layer * fw[layer]
      true -> 0
    end
  end

  def get_maxl({fw, _state, _time}), do: max(Map.keys(fw))

  def part1(args) do
    state = args |> parse() |> init()

    0..get_maxl(state)
    |> Enum.reduce({state, 0}, fn layer, {state, score} ->
      {tick(state), score + collide_score(state, layer)}
    end)
    |> elem(1)
  end

  def part2(_args) do
    #    args = "0: 3\n1: 2\n4: 4\n6: 4"
    :ok
  end
end
