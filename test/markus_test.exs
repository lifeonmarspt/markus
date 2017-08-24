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
end
