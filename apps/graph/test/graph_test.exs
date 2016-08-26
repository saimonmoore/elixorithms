defmodule GraphTest do
  use ExUnit.Case
  doctest Graph

  @elements %{
    lefkosia: {:lefkosia, 294291},
    lemesos: {:lemesos, 101000},
    paphos: {:paphos, 32892},
    larnaca: {:larnaca, 51468},
    polis: {:polis, 3690},
    anogira: {:anogira, 244},
    kato_platres: {:kato_platres, 210},
    omodos: {:omodos, 284},
    pissouri: {:pissouri, 1033},
    pera_pedi: {:pera_pedi, 66},
    trimiklini: {:trimiklini, 170},
  }

  setup do
    adj_list = Graph.new(:adj_list)
    adj_matrix = Graph.new(:adj_matrix)

    {:ok, [adj_list: adj_list, adj_matrix: adj_matrix]}
  end

  describe "AdjacencyList" do
    test "addVertex", %{adj_list: graph} do
      g = Graph.add_vertex(graph, @elements[:lefkosia])
      outlist = g.graph.outlist
      {_, attributes} = outlist[0]
      assert attributes == @elements[:lefkosia]
    end

    test "addEdge", %{adj_list: graph} do
      g_with_vertices = Graph.add_vertex(graph, @elements[:lefkosia])
      |>  Graph.add_vertex(@elements[:lemesos])
      |>  Graph.add_vertex(@elements[:larnaca])
      |>  Graph.add_vertex(@elements[:paphos])

      g = Graph.add_edge(g_with_vertices, 0, 3)

      outlist = g.graph.outlist
      {edge_list, _} = outlist[0]
      assert edge_list[0][:ref] == {0,3}
      assert edge_list[0][:attributes] == %{}
    end
  end
end
