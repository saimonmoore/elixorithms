defmodule InsertionSort do
  def sort(list) do
    init_list
    do_sort(list)
  end

  defp do_sort([]), do: []
  defp do_sort(list) when is_list(list) do
    l = length(list)
    update_list(list)
    1..(l - 1) |> Enum.each(fn(i) ->
      current_list = get_list
      current = Enum.at(current_list, i)
      j = i - 1
      previous = Enum.at(current_list, j)
      {new_list, new_j} = switch_elements(current_list, j, previous, current)
      update_list(List.replace_at(new_list, new_j + 1, current))
    end)
    get_list
  end

  defp switch_elements(list, j, previous, current) when j >= 0 do
    cond do
      previous > current ->
				new_list = List.replace_at(list, j + 1, previous)
				new_j = j - 1
				new_previous = Enum.at(new_list, new_j)
				switch_elements(new_list, new_j, new_previous, current)
      true ->
        {list, j}
    end
  end
  defp switch_elements(list, j, _, _) when j < 0 do
    {list, j}
  end

  defp update_list(list) do
    Agent.get_and_update(__MODULE__, fn(_) ->
      {list, list}
    end)
  end

  defp init_list do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  defp get_list do
    Agent.get(__MODULE__, fn(list) ->
      list
    end)
  end
end
