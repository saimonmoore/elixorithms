defmodule CollatzTest do
  use ExUnit.Case
  doctest Collatz

  describe "when n = 8" do
    test "takes 3 cycles to get to 1" do
      assert Collatz.stream(8) |> Stream.take(3) |> Enum.to_list |> List.last == 1
    end

    test "cycles are 8 -> 4 -> 2 -> 1" do
      assert Collatz.stream(8) |> Enum.to_list == [4,2,1]
    end
  end

  describe "when n = 3" do
    test "takes 7 cycles to get to 1" do
      assert Collatz.stream(3) |> Stream.take(7) |> Enum.to_list |> List.last == 1
    end

    test "cycles are 3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1" do
      assert Collatz.stream(3) |> Enum.to_list == [10,5,16,8,4,2,1]
    end
  end

  describe "Collatz.max_cycles_for" do
    test "when max value == 10" do
      assert Collatz.max_cycles_for(10) == 9
    end
  end
end
