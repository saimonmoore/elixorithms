# c.f ruby version:
#
# class QuickSort
#   def sort(list)
#     return [] if list.empty?
#     pivot, rest = list.first, list[1..-1]
#
#     left, right = *rest.partition {|e| e < pivot}
#     sort(left).concat([pivot].concat(sort(right)))
#   end
# end
#
# Both are pretty readable but the elixir version looks more elegant.

defmodule Quicksort do
  def sort([]), do: []
  def sort([pivot | rest]) do
    { left, right } = Enum.partition(rest, &(&1 < pivot))
    sort(left) ++ [pivot | sort(right)]
  end
end
