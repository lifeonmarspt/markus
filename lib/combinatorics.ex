defmodule Markus.Combinatorics do
  def combine(_, 0), do: [[]]
  def combine([], _), do: []
  def combine([h|t], k), do: (for l <- combine(t, k - 1), do: [h|l]) ++ combine(t, k)

  def multiply([]), do: []
  def multiply([as]), do: for a <- as, do: [a]
  def multiply([as|others]), do: for a <- as, rest <- multiply(others), do: [a|rest]
end
