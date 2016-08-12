defmodule Mergesort do
  def sort([]), do: []
  def sort(list) do
    divide(list)
  end

  defp divide(list) when length(list) == 1 do
    list
  end
  defp divide(list) do
    {left, right} = Enum.split(list, div(length(list), 2))

    merge([], divide(left), divide(right))
  end

  defp merge(sorted, left, right) when length(left) == 0 and length(right) == 0 do
    sorted
  end
  defp merge(sorted, left, right) when length(left) > 0 and length(right) > 0 do
    [lh | lrest] = left
    [rh | rrest] = right
    if lh <= rh do
        merge(sorted ++ [lh], lrest, right)
    else
        merge(sorted ++ [rh], left, rrest)
    end
  end
  defp merge(sorted, left, right) when length(left) > 0 do
    [lh | lrest] = left
    merge(sorted ++ [lh], lrest, right)
  end
  defp merge(sorted, left, right) when length(right) > 0 do
    [rh | rrest] = right
    merge(sorted ++ [rh], left, rrest)
  end
end
