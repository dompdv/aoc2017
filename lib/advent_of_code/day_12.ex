defmodule AdventOfCode.Day12 do
  def parse(args) do
    args
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [id, neighbours] = String.split(line, " <-> ", trim: true)

      {String.to_integer(id),
       String.split(neighbours, ", ", trim: true) |> Enum.map(&String.to_integer/1)}
    end)
    |> Map.new()
  end

  def find_connex(_, [], visited), do: visited

  # Maintien une liste de noeuds à visiter et une liste de noeuds visités
  def find_connex(graph, [node | to_visit], visited) do
    # Si déjà visité, on passe au suivant
    if MapSet.member?(visited, node) do
      find_connex(graph, to_visit, visited)
    else
      # Sinon, on ajoute les voisins à visiter et on ajoute le noeud aux visités
      find_connex(graph, to_visit ++ graph[node], MapSet.put(visited, node))
    end
  end

  def find_group(graph, node), do: find_connex(graph, [node], MapSet.new())

  def part1(args) do
    args |> parse() |> find_group(0) |> Enum.count()
  end

  def part2(_args) do
    :ok
  end
end
