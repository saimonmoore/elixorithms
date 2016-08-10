defmodule Spalindrome do
  def word_combinations(combinations, left, right) do
    result = combinations ++ (left ++ [right])
    add_result(result)

    max = String.length(right)

    if max > 1 do
      for i <- 1..(max - 1) do
        word_combinations(result, left ++ [String.slice(right, 0..i)], String.slice(right, i..max))
      end
    end
    get_combinations
  end

  def all(word) do
    init_combinations
    wc = word_combinations([], [], word)
    palindromes = wc |> Enum.filter(fn(fragment) ->
      if is_palindrome?(fragment) do
        [fragment]
      end
    end)
    palindromes |> Enum.uniq
  end

  defp is_palindrome?(fragment) do
    fragment == String.reverse(fragment)
  end

  defp add_result(result) do
    Agent.get_and_update(__MODULE__, fn(current) ->
      new_result = current ++ result
      {new_result, new_result}
    end)
  end

  defp init_combinations do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  defp get_combinations do
    Agent.get(__MODULE__, fn(combinations) ->
      combinations
    end)
  end
end
