defmodule Markus do
  @moduledoc """
  Documentation for Markus.
  """
  alias Markus.Combinatorics
  alias Markus.Logic


  defp burying_pairs(ballot, all_candidates) do
    Combinatorics.multiply([
      ballot,
      Enum.reject(all_candidates, &Enum.member?(ballot, &1))
    ])
  end

  def ballot_to_pairs(ballot, all_candidates) do
    Enum.concat(
      Combinatorics.combine(ballot, 2),
      burying_pairs(ballot, all_candidates)
    )
  end

  defp candidates_matrix(all_candidates) do
    Combinatorics.multiply([all_candidates, all_candidates])
    |> Enum.filter(&Logic.all_different/1)
    |> Map.new(&{&1, 0})
  end

  def pairs_to_preferences(pairs, all_candidates) do
    pairs
    |> Enum.reduce(
      candidates_matrix(all_candidates),
      fn pair, matrix ->
        matrix
        |> Map.update!(pair, &(&1 + 1))
      end
    )
  end

  defp map_matrix(nodes, mapper) do
    Combinatorics.multiply([nodes, nodes])
    |> Enum.filter(&Logic.all_different/1)
    |> Enum.map(fn [a, b] -> {[a, b], mapper.(a, b)} end)
    |> Map.new
  end

  def normalize_wins(preferences, all_candidates) do
    map_matrix(
      all_candidates,
      fn a, b ->
        if preferences[[a,b]] > preferences[[b, a]] do
          preferences[[a,b]]
        else
          0
        end
      end
    )
  end

  def widen_paths(adjacencies, nodes) do
    Enum.reduce(
      nodes,
      adjacencies,
      fn pivot, scores ->
        map_matrix(
          nodes,
          fn a, b ->
            max(
              scores[[a, b]],
              min(
                scores[[a, pivot]],
                scores[[pivot, b]]
              )
            )
          end
        )
      end
    )
  end

  defp loses_to(scores, a, b), do: scores[[a, b]] < scores[[b, a]]

  def schwartz_set(scores, all_candidates) do
    all_candidates
    |> Enum.reject(
      fn a ->
        Enum.any?(
          List.delete(all_candidates, a)
          |> Stream.filter(fn b -> loses_to(scores, a, b) end)
        )
      end
    )
  end

  def rank_candidates(scores, all_candidates) do
    all_candidates
    |> Enum.group_by(
      fn a ->
          List.delete(all_candidates, a)
          |> Enum.reject(fn b -> loses_to(scores, a, b) end)
          |> Enum.count
      end
    )
    |> Enum.sort
    |> Enum.reverse
  end

  def sort_candidates_with_tie_breakers(scores, all_candidates, tie_breakers) do
    scores
    |> rank_candidates(all_candidates)
    |> Enum.map(&elem(&1, 1))
    |> Enum.flat_map(fn level ->
      level
      |> Enum.map(&{tie_breakers[&1], &1})
      |> Enum.sort
      |> Enum.map(&elem(&1, 1))
    end)
  end
end
