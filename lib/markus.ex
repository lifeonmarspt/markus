defmodule Markus do
  @moduledoc """
  Documentation for Markus.
  """

  defp burrying_pairs(ballot, all_candidates) do
    for a <- ballot,
        b <- Stream.reject(all_candidates, &Enum.member?(ballot, &1))
    do
      [a, b]
    end
  end

  def ballot_to_pairs(ballot, all_candidates) do
    Stream.concat(
      Markus.Combinatorics.combine(ballot, 2),
      burrying_pairs(ballot, all_candidates)
    )
    |> Enum.to_list
  end

  defp candidates_matrix(all_candidates) do
    for a <- all_candidates,
        b <- all_candidates
    do
      [a, b]
    end
    |> Map.new(&{&1, 0})
  end

  defp inc(a), do: a + 1

  def pairs_to_preferences(pairs, all_candidates) do
    pairs
    |> Enum.reduce(
      candidates_matrix(all_candidates),
      fn pair, matrix ->
        matrix
        |> Map.update!(pair, &inc/1)
      end
    )
  end
end
