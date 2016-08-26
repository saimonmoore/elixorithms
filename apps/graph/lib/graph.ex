defmodule Graph do
  alias Graph.AdjacencyList
  alias Graph.AdjacencyMatrix

  def new(type) do
    case type do
      :adj_list -> new_adjacency_list
      :adj_matrix -> new_adjacency_matrix
    end
  end

  def add_vertex(%__MODULE{type: t} = graph, element) do
    case t do
      :adj_list -> AdjacencyList.add_vertex(graph, element)
      :adj_matrix -> AdjacencyMatrix.add_vertex(graph, element)
    end
  end

  def add_edge(%__MODULE{type: t} = graph, i, j, attributes \\ %{}) do
    case t do
      :adj_list -> AdjacencyList.add_edge(%__MODULE{type: t} = graph, i, j, attributes)
      :adj_matrix -> AdjacencyMatrix.add_edge(%__MODULE{type: t} = graph, i,j, attributes)
    end
  end

  defp new_adjacency_list do
    Graph.AdjacencyList.new
  end

  defp new_adjacency_matrix do
    Graph.AdjacencyMatrix.new
  end
end
