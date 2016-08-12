defmodule Mergesort2Test do
  use ExUnit.Case
  doctest Mergesort2

  test "the truth" do
    assert Mergesort2.sort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]
  end
end
