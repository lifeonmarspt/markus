defmodule Markus.WikipediaTestHelpers do
  def n_copies(n, vote), do: Stream.cycle([vote]) |> Enum.take(n)
  def unroll_votes(vote_counts, all_candidates) do
    vote_counts
    |> Enum.flat_map(fn [n, vote] -> n_copies(n, vote) end)
    |> Enum.flat_map(&Markus.ballot_to_pairs(String.graphemes(&1), all_candidates))
  end
end

defmodule Markus.WikipediaTest do
  use ExUnit.Case
  doctest Markus
  alias Markus.WikipediaTestHelpers, as: Helpers

  @candidates String.graphemes("ABCDE")

  @votes Helpers.unroll_votes(
    [
      [5, "ACBED"],
      [5, "ADECB"],
      [8, "BEDAC"],
      [3, "CABED"],
      [7, "CAEBD"],
      [2, "CBADE"],
      [7, "DCEBA"],
      [8, "EBADC"],
    ],
    @candidates
  )

  @preferences %{
    ["A", "B"] => 20,
    ["A", "C"] => 26,
    ["A", "D"] => 30,
    ["A", "E"] => 22,

    ["B", "A"] => 25,
    ["B", "C"] => 16,
    ["B", "D"] => 33,
    ["B", "E"] => 18,

    ["C", "A"] => 19,
    ["C", "B"] => 29,
    ["C", "D"] => 17,
    ["C", "E"] => 24,

    ["D", "A"] => 15,
    ["D", "B"] => 12,
    ["D", "C"] => 28,
    ["D", "E"] => 14,

    ["E", "A"] => 23,
    ["E", "B"] => 27,
    ["E", "C"] => 21,
    ["E", "D"] => 31,
  }

  @normalized_preferences %{
    ["A", "B"] => 0,
    ["A", "C"] => 26,
    ["A", "D"] => 30,
    ["A", "E"] => 0,

    ["B", "A"] => 25,
    ["B", "C"] => 0,
    ["B", "D"] => 33,
    ["B", "E"] => 0,

    ["C", "A"] => 0,
    ["C", "B"] => 29,
    ["C", "D"] => 0,
    ["C", "E"] => 24,

    ["D", "A"] => 0,
    ["D", "B"] => 0,
    ["D", "C"] => 28,
    ["D", "E"] => 0,

    ["E", "A"] => 23,
    ["E", "B"] => 27,
    ["E", "C"] => 0,
    ["E", "D"] => 31,
  }

  @transitive_preferences %{
    ["A", "B"] => 28,
    ["A", "C"] => 28,
    ["A", "D"] => 30,
    ["A", "E"] => 24,

    ["B", "A"] => 25,
    ["B", "C"] => 28,
    ["B", "D"] => 33,
    ["B", "E"] => 24,

    ["C", "A"] => 25,
    ["C", "B"] => 29,
    ["C", "D"] => 29,
    ["C", "E"] => 24,

    ["D", "A"] => 25,
    ["D", "B"] => 28,
    ["D", "C"] => 28,
    ["D", "E"] => 24,

    ["E", "A"] => 25,
    ["E", "B"] => 28,
    ["E", "C"] => 28,
    ["E", "D"] => 31,
  }

  test "pairs_to_preferences" do
    assert Markus.pairs_to_preferences(@votes, @candidates) == @preferences
  end

  test "normalize_wins" do
    assert Markus.normalize_wins(@preferences, @candidates) == @normalized_preferences
  end

  test "widen_paths" do
    assert Markus.widen_paths(@normalized_preferences, @candidates) == @transitive_preferences
  end

  test "schwartz_set" do
    assert Markus.schwartz_set(@transitive_preferences, @candidates) == ["E"]
  end

  test "rank_candidates" do
    assert Markus.rank_candidates(@transitive_preferences, @candidates) == [
      {4, ["E"]},
      {3, ["A"]},
      {2, ["C"]},
      {1, ["B"]},
      {0, ["D"]},
    ]
  end
end
