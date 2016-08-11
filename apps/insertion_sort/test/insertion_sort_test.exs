defmodule InsertionSortTest do
  use ExUnit.Case
  doctest InsertionSort

  test "it sorts" do
    assert InsertionSort.sort([4,3,5,2,1]) == [1,2,3,4,5]
  end
end
