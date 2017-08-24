defmodule MarkusTest do
  use ExUnit.Case
  doctest Markus

  test "ballot_to_pairs simple example" do
    assert Markus.ballot_to_pairs(String.graphemes("ACE"), String.graphemes("ABCDEF")) == [
      ["A", "C"],
      ["A", "E"],
      ["C", "E"],

      ["A", "B"],
      ["A", "D"],
      ["A", "F"],

      ["C", "B"],
      ["C", "D"],
      ["C", "F"],

      ["E", "B"],
      ["E", "D"],
      ["E", "F"],
    ]
  end

  test "pairs_to_preferences simple example" do
    assert Markus.pairs_to_preferences(
      [
        ["A", "C"],
        ["A", "E"],
        ["C", "E"],
      ],
      String.graphemes("ABCDEF")
    ) == %{
       ["A", "B"] => 0,
       ["A", "C"] => 1,
       ["A", "D"] => 0,
       ["A", "E"] => 1,
       ["A", "F"] => 0,
       ["B", "A"] => 0,
       ["B", "C"] => 0,
       ["B", "D"] => 0,
       ["B", "E"] => 0,
       ["B", "F"] => 0,
       ["C", "A"] => 0,
       ["C", "B"] => 0,
       ["C", "D"] => 0,
       ["C", "E"] => 1,
       ["C", "F"] => 0,
       ["D", "A"] => 0,
       ["D", "B"] => 0,
       ["D", "C"] => 0,
       ["D", "E"] => 0,
       ["D", "F"] => 0,
       ["E", "A"] => 0,
       ["E", "B"] => 0,
       ["E", "C"] => 0,
       ["E", "D"] => 0,
       ["E", "F"] => 0,
       ["F", "A"] => 0,
       ["F", "B"] => 0,
       ["F", "C"] => 0,
       ["F", "D"] => 0,
       ["F", "E"] => 0,
    }
  end
end
