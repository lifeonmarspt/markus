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
end
