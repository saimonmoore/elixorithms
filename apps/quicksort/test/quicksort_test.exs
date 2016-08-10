defmodule QuicksortTest do
  use ExUnit.Case
  doctest Quicksort

  test "sorts" do
    assert Quicksort.sort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]
  end
end
