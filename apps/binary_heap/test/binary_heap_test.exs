defmodule BinaryHeapTest do
  use ExUnit.Case
  doctest BinaryHeap

  setup do
    minheap = BinaryHeap.min
    maxheap = BinaryHeap.max
    {:ok, [minheap: minheap, maxheap: maxheap]}
  end

  describe "New" do
    test "new" do
      assert %BinaryHeap{type: :max, list: []} = BinaryHeap.new
    end
    test "new type: :min" do
      assert %BinaryHeap{type: :min, list: []} = BinaryHeap.new type: :min
    end
    test "new type: :max" do
      assert %BinaryHeap{type: :max, list: []} = BinaryHeap.new type: :max
    end
    test "#min" do
      assert %BinaryHeap{type: :min, list: []} = BinaryHeap.min
    end
    test "#max" do
      assert %BinaryHeap{type: :max, list: []} = BinaryHeap.max
    end
  end

  describe "Insertion" do
    test "root", %{minheap: heap} do
      assert BinaryHeap.insert(heap, 2) == %BinaryHeap{type: :min, list: [2]}
    end

    """
      For a graph like this:

      2
     /
    3
    """
    test "2 nodes 2 <= 3", %{minheap: heap} do
      one_node_heap_asc = BinaryHeap.insert(heap, 2)
      assert BinaryHeap.insert(one_node_heap_asc, 3) == %BinaryHeap{type: :min, list: [2,3]}
    end

    """
      For a graph like this:

      2
     /
    3
    """
    test "2 nodes 3 <= 2", %{minheap: heap} do
      one_node_heap_asc = BinaryHeap.insert(heap, 3)
      assert BinaryHeap.insert(one_node_heap_asc, 2) == %BinaryHeap{type: :min, list: [2,3]}
    end

    """
      For a graph like this:

      1
     / \
    3   2
    """
    test "3 nodes 3 <= 2 <= 1", %{minheap: heap} do
      three_node_heap = BinaryHeap.insert(heap, 3)
      |> BinaryHeap.insert(2)
      |> BinaryHeap.insert(1)
      assert three_node_heap == %BinaryHeap{type: :min, list: [1,3,2]}
    end

    """
      For a graph like this:

      1
     / \
    2   3
   /
  4
    """
    test "4 nodes 4 <= 3 <= 2 <= 1", %{minheap: heap} do
      three_node_heap = BinaryHeap.insert(heap, 4)
      |> BinaryHeap.insert(3)
      |> BinaryHeap.insert(2)
      |> BinaryHeap.insert(1)
      assert three_node_heap == %BinaryHeap{type: :min, list: [1,2,3,4]}
    end

    """
      For a graph like this:

      1
     / \
    2   4
   / \
  5   3
    """
    test "5 nodes 5 <= 4 <= 3 <= 2 <= 1", %{minheap: heap} do
      three_node_heap = BinaryHeap.insert(heap, 5)
      |> BinaryHeap.insert(4)
      |> BinaryHeap.insert(3)
      |> BinaryHeap.insert(2)
      |> BinaryHeap.insert(1)
      assert three_node_heap == %BinaryHeap{type: :min, list: [1,2,4,5,3]}
    end
  end
end
