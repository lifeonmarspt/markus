defmodule Markus do
  @moduledoc """
  Documentation for Markus.
  """

  def ballot_to_pairs(ballot, all_candidates) do
    Stream.concat(
      Markus.Combinatorics.combine(ballot, 2),
      burrying_pairs(ballot, all_candidates)
    )
    |> Enum.to_list
  end

  defp burrying_pairs(ballot, all_candidates) do
    for a <- ballot,
        b <- Stream.reject(all_candidates, &Enum.member?(ballot, &1))
    do
      [a, b]
    end
  end
end
