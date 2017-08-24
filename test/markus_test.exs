defmodule Markus.Test do
  use ExUnit.Case
  doctest Markus

  @candidates String.graphemes("ABCDE")

  test "ballot_to_pairs simple example" do
    assert Markus.ballot_to_pairs(
      String.graphemes("ACE"),
      @candidates
    ) == [
      ["A", "C"],
      ["A", "E"],
      ["C", "E"],

      ["A", "B"],
      ["A", "D"],

      ["C", "B"],
      ["C", "D"],

      ["E", "B"],
      ["E", "D"],
    ]
  end

  test "pairs_to_preferences simple example" do
    assert Markus.pairs_to_preferences(
      [
        ["A", "C"],
        ["A", "E"],
        ["C", "E"],
        ["C", "E"],
      ],
      @candidates
    ) == %{
       ["A", "B"] => 0,
       ["A", "C"] => 1,
       ["A", "D"] => 0,
       ["A", "E"] => 1,
       ["B", "A"] => 0,
       ["B", "C"] => 0,
       ["B", "D"] => 0,
       ["B", "E"] => 0,
       ["C", "A"] => 0,
       ["C", "B"] => 0,
       ["C", "D"] => 0,
       ["C", "E"] => 2,
       ["D", "A"] => 0,
       ["D", "B"] => 0,
       ["D", "C"] => 0,
       ["D", "E"] => 0,
       ["E", "A"] => 0,
       ["E", "B"] => 0,
       ["E", "C"] => 0,
       ["E", "D"] => 0,
    }
  end

  test "normalize_wins simple example" do
    assert Markus.normalize_wins(%{
       ["A", "B"] => 10,
       ["A", "C"] => 1,
       ["A", "D"] => 10,
       ["A", "E"] => 1,
       ["B", "A"] => 1,
       ["B", "C"] => 10,
       ["B", "D"] => 1,
       ["B", "E"] => 1,
       ["C", "A"] => 1,
       ["C", "B"] => 10,
       ["C", "D"] => 1,
       ["C", "E"] => 1,
       ["D", "A"] => 1,
       ["D", "B"] => 1,
       ["D", "C"] => 1,
       ["D", "E"] => 1,
       ["E", "A"] => 1,
       ["E", "B"] => 1,
       ["E", "C"] => 1,
       ["E", "D"] => 1,
    }, @candidates) == %{
      ["A", "B"] => 10,
      ["A", "C"] => 0,
      ["A", "D"] => 10,
      ["A", "E"] => 0,
      ["B", "A"] => 0,
      ["B", "C"] => 0,
      ["B", "D"] => 0,
      ["B", "E"] => 0,
      ["C", "A"] => 0,
      ["C", "B"] => 0,
      ["C", "D"] => 0,
      ["C", "E"] => 0,
      ["D", "A"] => 0,
      ["D", "B"] => 0,
      ["D", "C"] => 0,
      ["D", "E"] => 0,
      ["E", "A"] => 0,
      ["E", "B"] => 0,
      ["E", "C"] => 0,
      ["E", "D"] => 0,
    }
  end

  test "widen_paths simple example" do
    assert Markus.widen_paths(%{
       ["A", "B"] => 0,
       ["A", "C"] => 10,
       ["A", "D"] => 0,
       ["A", "E"] => 0,
       ["B", "A"] => 10,
       ["B", "C"] => 0,
       ["B", "D"] => 0,
       ["B", "E"] => 0,
       ["C", "A"] => 0,
       ["C", "B"] => 10,
       ["C", "D"] => 15,
       ["C", "E"] => 0,
       ["D", "A"] => 0,
       ["D", "B"] => 0,
       ["D", "C"] => 0,
       ["D", "E"] => 20,
       ["E", "A"] => 0,
       ["E", "B"] => 0,
       ["E", "C"] => 0,
       ["E", "D"] => 0,
    }, @candidates) == %{
      ["A", "B"] => 10,
      ["A", "C"] => 10,
      ["A", "D"] => 10,
      ["A", "E"] => 10,
      ["B", "A"] => 10,
      ["B", "C"] => 10,
      ["B", "D"] => 10,
      ["B", "E"] => 10,
      ["C", "A"] => 10,
      ["C", "B"] => 10,
      ["C", "D"] => 15,
      ["C", "E"] => 15,
      ["D", "A"] => 0,
      ["D", "B"] => 0,
      ["D", "C"] => 0,
      ["D", "E"] => 20,
      ["E", "A"] => 0,
      ["E", "B"] => 0,
      ["E", "C"] => 0,
      ["E", "D"] => 0,
    }
  end

  test "schwartz_set e" do
    assert Markus.schwartz_set(%{
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
      ["E", "D"] => 31
    }, @candidates) == String.graphemes("E")
  end

  test "schwartz_set abc" do
    assert Markus.schwartz_set(%{
      ["A", "B"] => 10,
      ["A", "C"] => 10,
      ["A", "D"] => 5,
      ["A", "E"] => 2,
      ["B", "A"] => 10,
      ["B", "C"] => 10,
      ["B", "D"] => 5,
      ["B", "E"] => 2,
      ["C", "A"] => 10,
      ["C", "B"] => 10,
      ["C", "D"] => 5,
      ["C", "E"] => 2,
      ["D", "A"] => 0,
      ["D", "B"] => 0,
      ["D", "C"] => 0,
      ["D", "E"] => 2,
      ["E", "A"] => 0,
      ["E", "B"] => 0,
      ["E", "C"] => 0,
      ["E", "D"] => 0,
    }, @candidates) == String.graphemes("ABC")
  end

  test "rank_candidates e" do
    assert Markus.rank_candidates(%{
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
      ["E", "D"] => 31
    }, @candidates) == [
      {4, ["E"]},
      {3, ["A"]},
      {2, ["C"]},
      {1, ["B"]},
      {0, ["D"]}
    ]
  end

  test "rank_candidates abc" do
    assert Markus.rank_candidates(%{
      ["A", "B"] => 10,
      ["A", "C"] => 10,
      ["A", "D"] => 5,
      ["A", "E"] => 2,
      ["B", "A"] => 10,
      ["B", "C"] => 10,
      ["B", "D"] => 5,
      ["B", "E"] => 2,
      ["C", "A"] => 10,
      ["C", "B"] => 10,
      ["C", "D"] => 5,
      ["C", "E"] => 2,
      ["D", "A"] => 0,
      ["D", "B"] => 0,
      ["D", "C"] => 0,
      ["D", "E"] => 2,
      ["E", "A"] => 0,
      ["E", "B"] => 0,
      ["E", "C"] => 0,
      ["E", "D"] => 0,
    }, @candidates) == [
      {4, ["A", "B", "C"]},
      {1, ["D"]},
      {0, ["E"]}
    ]
  end
end
