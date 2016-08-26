defmodule Graph.AdjacencyList do
  defstruct type: :adj_list, graph: %{outlist: Array.new, inlist: Array.new}

  def new do
    struct(__MODULE__)
  end

  def add_vertex(%__MODULE{graph: g} = graph, element) do
    outlist = append_to_array(g[:outlist], {Array.new, element})
    inlist = append_to_array(g[:inlist], {Array.new, element})
    Map.merge(graph, %{graph: %{outlist: outlist, inlist: inlist}})
  end

  def add_edge(graph, i, j, attributes \\ %{}) do
    outlist = add_edge_to_outlist(graph, i, j, attributes)
    inlist = add_edge_to_inlist(graph, i, j, attributes)
    Map.merge(graph, %{graph: %{outlist: outlist, inlist: inlist}})
  end

  defp add_edge_to_outlist(%__MODULE{graph: g}, i, j, attributes) do
    {ol, vertex} = g[:outlist][i]
    ol_edge = %{ref: {i,j}, attributes: attributes}
    Array.set(g[:outlist], i, {append_to_array(ol, ol_edge), vertex})
  end

  defp add_edge_to_inlist(%__MODULE{graph: g}, i, j, attributes) do
    {il, vertex} = g[:inlist][j]
    il_edge = %{ref: {j,i}, attributes: attributes}
    Array.set(g[:inlist], j, {append_to_array(il, il_edge), vertex})
  end

  defp append_to_array(array, element) do
    Array.set(array, Array.size(array), element)
  end
end
