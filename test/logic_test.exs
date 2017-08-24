defmodule Markus.Logic.Test do
  use ExUnit.Case, async: true
  import Markus.Logic

  test "all_different yes" do
    assert all_different([1,2,3]) == true
  end

  test "all_different no adjacent" do
    assert all_different([1,1,3]) == false
  end

  test "all_different no far" do
    assert all_different([1,3,1]) == false
  end
end
