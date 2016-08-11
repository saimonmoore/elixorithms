defmodule MergesortTest do
  use ExUnit.Case
  doctest Mergesort

  test "the truth" do
    assert Mergesort.sort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]
  end
end
