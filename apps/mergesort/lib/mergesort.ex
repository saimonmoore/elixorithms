defmodule Mergesort do
  def sort([]), do: []
  def sort(list) do
    divide(list)
  end

  defp divide(list) when length(list) == 1 do
    list
  end
  defp divide(list) do
    l = length(list)
    q = Float.floor(l / 2) |> trunc
    left = Enum.slice(list, 0, q)
    right = Enum.slice(list, q, l)

    left = divide(left)
    right = divide(right)

    merge([], left, right)
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
