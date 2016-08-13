defmodule BinaryHeap do
  defstruct type: :max, list: []

  def new(opts \\ []) do
    struct(__MODULE__, opts)
  end

  def min do
    new(type: :min)
  end

  def max do
    new(type: :max)
  end

  def root(%__MODULE{list: [h | _]}) do
    h
  end

  def insert(%__MODULE{list: list} = heap, element) when length(list) == 0 do
    list = [element]
    Map.merge(heap, %{list: list})
  end

  def insert(%__MODULE{list: list} = heap, element) when length(list) > 0 do
    new_list = list ++ [element]
    new_heap = Map.merge(heap, %{list: new_list})
    heapify(new_heap, length(new_list) - 1)
  end

  defp heapify(heap, element) do
    parent = parent_i(element)
    parent_check(heap, element, parent)
  end

  defp parent_i(position) do
    Float.floor((position - 1) / 2) |> trunc
  end

  defp children_i(position) do
    {(position * 2 + 1), (position * 2 + 2)}
  end

  def parent_check(%__MODULE{list: list} = heap, _, _) when length(list) <= 1 do
    heap
  end
  def parent_check(heap, element, parent) do
    case heap.type do
      :min -> min_parent_check(heap, element, parent)
      :max -> max_parent_check(heap, element, parent)
      _ -> heap
    end
  end

  defp min_parent_check(%__MODULE{list: list} = heap, element, parent) do
    parentv = Enum.at(list, parent)
    elementv = Enum.at(list, element)
    p = get_comparator(parentv)
    e = get_comparator(elementv)

    cond do
      p < e -> heap
      p > e -> do_swap(heap, element, parent)
    end
  end

  defp max_parent_check(%__MODULE{list: list} = heap, element, parent) do
    parentv = Enum.at(list, parent)
    elementv = Enum.at(list, element)
    p = get_comparator(parentv)
    e = get_comparator(elementv)

    cond do
      p > e -> heap
      p < e -> do_swap(heap, element, parent)
    end
  end

  defp do_swap(%__MODULE{list: list} = heap, element, parent) do
    parentv = Enum.at(list, parent)
    elementv = Enum.at(list, element)
    plist = List.replace_at(list, parent, elementv)
    elist = List.replace_at(plist, element, parentv)
    new_heap = Map.merge(heap, %{list: elist})
    case parent do
      0 -> new_heap
      _ -> parent_check(new_heap, parent, parent_i(parent))
    end
  end

  defp get_comparator(value) do
    case value do
      value when is_integer(value) -> value
      {index, _} when is_integer(index) -> index
      _ -> nil
    end
  end
end
