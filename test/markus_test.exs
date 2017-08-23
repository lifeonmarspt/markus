defmodule MarkusTest do
  use ExUnit.Case
  doctest Markus

  test "greets the world" do
    assert Markus.hello() == :world
  end
end
