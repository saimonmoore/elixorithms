defmodule ParallelMapTest do
  use ExUnit.Case
  doctest ParallelMap

  test "maps correctly" do
    assert ParallelMap.map(1..5, fn(n) -> :math.pow(2,n) |> trunc end) == [2,4,8,16,32]
  end
end
