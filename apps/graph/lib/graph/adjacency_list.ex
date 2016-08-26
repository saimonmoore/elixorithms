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

  def remove_edge(graph, i, j) do
    outlist = remove_edge_from_outlist(graph, i, j)
    inlist = remove_edge_from_inlist(graph, i, j)

    case outlist do
      :error -> :error
      _ -> Map.merge(graph, %{graph: %{outlist: outlist, inlist: inlist}})
    end
  end

  def has_edge(graph, i, j) do
    is_edge_in_outlist(graph, i, j)
  end

  def out_edges(%__MODULE{graph: g}, i) do
    {out_edges, _} = g[:outlist][i]
    out_edges
  end

  def in_edges(%__MODULE{graph: g}, i) do
    {in_edges, _} = g[:inlist][i]
    in_edges
  end

  defp add_edge_to_outlist(%__MODULE{graph: g}, i, j, attributes) do
    {ol, vertex} = g[:outlist][i]
    ol_edge = %{ref: {i,j}, attributes: attributes}
    Array.set(g[:outlist], i, {append_to_array(ol, ol_edge), vertex})
  end

  defp add_edge_to_inlist(%__MODULE{graph: g}, i, j, attributes) do
    {il, vertex} = g[:inlist][j]
    il_edge = %{ref: {i,j}, attributes: attributes}
    Array.set(g[:inlist], j, {append_to_array(il, il_edge), vertex})
  end

  defp remove_edge_from_outlist(%__MODULE{graph: g}, i, j) do
    {ol, vertex} = g[:outlist][i]
    edge = Enum.find_index(ol, fn(edge) -> edge[:ref] == {i,j} end)

    cond do
      is_number(edge) -> Array.set(g[:outlist], i, {Array.reset(ol, edge) |> Array.resize, vertex})
      true -> :error
    end
  end

  defp remove_edge_from_inlist(%__MODULE{graph: g}, i, j) do
    {il, vertex} = g[:inlist][j]
    edge = Enum.find_index(il, fn(edge) -> edge[:ref] == {i,j} end)

    cond do
      is_number(edge) -> Array.set(g[:inlist], j, {Array.reset(il, edge) |> Array.resize, vertex})
      true -> :error
    end
  end

  defp is_edge_in_outlist(%__MODULE{graph: g}, i, j) do
    {ol, _} = g[:outlist][i]
    Enum.any?(ol, fn(edge) -> edge[:ref] == {i,j} end)
  end

  defp append_to_array(array, element) do
    Array.set(array, Array.size(array), element)
  end
end
