defmodule Markus.Combinatorics.Test do
  use ExUnit.Case, async: true
  import Markus.Combinatorics

  test "combinations basic usage" do
    assert combine(Enum.to_list(1..3), 2) == [
      [1, 2],
      [1, 3],
      [2, 3],
    ]
  end

  test "combinations repeated differnt parameters" do
    assert combine([:a, :b, :c, :d], 3) == [
      [:a, :b, :c],
      [:a, :b, :d],
      [:a, :c, :d],
      [:b, :c, :d],
    ]
  end

  test "combinations repeated parameters" do
    assert combine([1, 1, 2, 2], 3) == [
      [1, 1, 2],
      [1, 1, 2],
      [1, 2, 2],
      [1, 2, 2],
    ]
  end

  test "multiply simple example" do
    assert multiply([[1, 2], ["A", "B"], ["!", "@"]]) == [
      [1, "A", "!"],
      [1, "A", "@"],
      [1, "B", "!"],
      [1, "B", "@"],
      [2, "A", "!"],
      [2, "A", "@"],
      [2, "B", "!"],
      [2, "B", "@"],
    ]
  end

  test "multiply one enumerable" do
    assert multiply([[1, 2]]) == [
      [1],
      [2],
    ]
  end

  test "multiply nothing" do
    assert multiply([]) == []
  end
end
