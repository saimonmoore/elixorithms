defmodule BinaryHeapTest do
  use ExUnit.Case
  doctest BinaryHeap

  setup do
    minheap = BinaryHeap.min
    maxheap = BinaryHeap.max
    {:ok, [minheap: minheap, maxheap: maxheap]}
  end

  describe "New" do
    test "#new" do
      assert %BinaryHeap{type: :max, list: []} = BinaryHeap.new
    end
    test "#new type: :min" do
      assert %BinaryHeap{type: :min, list: []} = BinaryHeap.new type: :min
    end
    test "#new type: :max" do
      assert %BinaryHeap{type: :max, list: []} = BinaryHeap.new type: :max
    end
    test "#min" do
      assert %BinaryHeap{type: :min, list: []} = BinaryHeap.min
    end
    test "#max" do
      assert %BinaryHeap{type: :max, list: []} = BinaryHeap.max
    end
  end

  describe "Collectable" do
    test "#root" do
      heap_with_root_one = 1..500 |> Enum.shuffle |> Enum.into(BinaryHeap)
      assert BinaryHeap.root(heap_with_root_one) == 1
    end
  end

  describe "Root" do
    test "#root", %{minheap: heap} do
      heap_with_root_one = 1..500 |> Enum.shuffle |> Enum.reduce(heap, fn(e, h) -> BinaryHeap.push(h, e) end)
      assert BinaryHeap.root(heap_with_root_one) == 1
    end
  end



  describe "push" do
    test "one node", %{minheap: heap} do
      assert BinaryHeap.push(heap, 2) == %BinaryHeap{type: :min, list: [2]}
    end

     # For a graph like this:

     #    2
     #   /
     #  3
    test "2 nodes 2 <= 3", %{minheap: heap} do
      one_node_heap_asc = BinaryHeap.push(heap, 2)
      assert BinaryHeap.push(one_node_heap_asc, 3) == %BinaryHeap{type: :min, list: [2,3]}
    end

     # For a graph like this:

     #   2
     #  /
     # 3
    test "2 nodes 3 <= 2", %{minheap: heap} do
      one_node_heap_asc = BinaryHeap.push(heap, 3)
      assert BinaryHeap.push(one_node_heap_asc, 2) == %BinaryHeap{type: :min, list: [2,3]}
    end

    # For a graph like this:

    #   1
    #  / \
    # 3   2
    test "3 nodes 3 <= 2 <= 1", %{minheap: heap} do
      three_node_heap = BinaryHeap.push(heap, 3)
      |> BinaryHeap.push(2)
      |> BinaryHeap.push(1)
      assert three_node_heap == %BinaryHeap{type: :min, list: [1,3,2]}
    end

    # For a graph like this:

    #     1
    #    / \
    #   2   3
    #  /
    # 4
    test "4 nodes 4 <= 3 <= 2 <= 1", %{minheap: heap} do
      three_node_heap = BinaryHeap.push(heap, 4)
      |> BinaryHeap.push(3)
      |> BinaryHeap.push(2)
      |> BinaryHeap.push(1)
      assert three_node_heap == %BinaryHeap{type: :min, list: [1,2,3,4]}
    end

    # For a graph like this:

    #     1
    #    / \
    #   2   4
    #  / \
    # 5   3
    test "5 nodes 5 <= 4 <= 3 <= 2 <= 1", %{minheap: heap} do
      three_node_heap = BinaryHeap.push(heap, 5)
      |> BinaryHeap.push(4)
      |> BinaryHeap.push(3)
      |> BinaryHeap.push(2)
      |> BinaryHeap.push(1)
      assert three_node_heap == %BinaryHeap{type: :min, list: [1,2,4,5,3]}
    end

    # For a graph like this:

    #         {1, :fruit}
    #        /          \
    #       {2, :eggs}   {4, :fish}
    #      /         \
    #     {5, :meat}   {3, :legumes}
    test "5 nodes with tuples", %{minheap: heap} do
      {index, food} = BinaryHeap.push(heap, {5, :meat})
      |> BinaryHeap.push({4, :fish})
      |> BinaryHeap.push({3, :legumes})
      |> BinaryHeap.push({2, :eggs})
      |> BinaryHeap.push({1, :fruit})
      |> BinaryHeap.root
      assert index == 1
      assert food == :fruit
    end
  end
end
