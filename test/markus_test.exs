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
end
