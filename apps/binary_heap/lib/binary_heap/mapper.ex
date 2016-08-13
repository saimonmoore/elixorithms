defmodule BinaryHeap.Mapper do
  def into(heap) do
   { heap, &into(heap, &1, &2) }
  end

  defp into(heap,  _, {:cont, item}), do: BinaryHeap.push(heap, item)
  defp into(heap, _, :done), do: heap
  defp into(_heap, _, :halt), do: :ok
end
