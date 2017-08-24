defmodule Markus.Logic do
  def all_different(as, comparer \\ &!=/2) do
    Markus.Combinatorics.combine(as, 2)
    |> Enum.map(fn [a, b] -> comparer.(a, b) end)
    |> Enum.all?
  end
end
