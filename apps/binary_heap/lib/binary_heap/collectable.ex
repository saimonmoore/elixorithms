defimpl Collectable, for: BinaryHeap do
  def into(heap) do
    BinaryHeap.Mapper.into(heap)
  end
end
