defmodule Mergesort2 do
  def sort(list) when length(list) <= 1, do: list
  """
    Takes advantage of erlang's :lists.merge/2
  """
  def sort(list) do
    {left, right} = Enum.split(list, div(length(list), 2))
    :lists.merge( sort(left), sort(right))
  end
end
