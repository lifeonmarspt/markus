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
end
