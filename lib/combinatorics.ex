defmodule Markus.Combinatorics do
  def combine(_, 0), do: [[]]
  def combine([], _), do: []
  def combine([h|t], k), do: (for l <- combine(t, k - 1), do: [h|l]) ++ combine(t, k)
end
