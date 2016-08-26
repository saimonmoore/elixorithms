defmodule Graph.AdjacencyMatrix do
  defstruct type: :adj_matrix, graph: %{matrix: Array.new}

  def new do
    struct(__MODULE__)
  end

  def add_vertex(%__MODULE{graph: g} = graph, element) do
    IO.inspect("#{inspect g} #{inspect graph} #{inspect element}")
  end

  def add_edge(graph, i, j, attributes \\ %{}) do
    IO.inspect("#{inspect graph} #{i} #{j} #{inspect attributes}")
  end
end
