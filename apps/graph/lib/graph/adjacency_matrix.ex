defmodule Graph.AdjacencyMatrix do
  defstruct type: :adj_matrix, graph: %{matrix: Array.new}

  def new do
    struct(__MODULE__)
  end

  def add_vertex(%__MODULE{graph: g} = graph, element) do
    IO.inspect("TODO: Implement me #{inspect g} #{inspect graph} #{inspect element}")
  end

  def add_edge(graph, i, j, attributes \\ %{}) do
    IO.inspect("TODO: Implement me #{inspect graph} #{i} #{j} #{inspect attributes}")
  end

  def remove_edge(graph, i, j) do
    IO.inspect("TODO: Implement me #{inspect graph} #{i} #{j}")
  end

  def has_edge(graph, i, j) do
    IO.inspect("TODO: Implement me #{inspect graph} #{i} #{j}")
  end

  def out_edges(%__MODULE{graph: g}, i) do
    IO.inspect("TODO: Implement me #{inspect g} #{i}")
  end

  def in_edges(%__MODULE{graph: g}, i) do
    IO.inspect("TODO: Implement me #{inspect g} #{i}")
  end
end
