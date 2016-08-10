defmodule SpalindromeTest do
  use ExUnit.Case
  doctest Spalindrome

  test "palindromes of 'nitin'" do
    assert Spalindrome.all("nitin") == ["nitin", "n", "iti"]
  end
end
