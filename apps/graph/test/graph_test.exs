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
    test "add_vertex", %{adj_list: graph} do
      g = Graph.add_vertex(graph, @elements[:lefkosia])
      outlist = g.graph.outlist
      {_, attributes} = outlist[0]
      assert attributes == @elements[:lefkosia]
    end

    test "add_edge", %{adj_list: graph} do
      g_with_vertices = Graph.add_vertex(graph, @elements[:lefkosia])
      |>  Graph.add_vertex(@elements[:lemesos])
      |>  Graph.add_vertex(@elements[:larnaca])
      |>  Graph.add_vertex(@elements[:paphos])

      g = Graph.add_edge(g_with_vertices, 0, 3)

      outlist = g.graph.outlist
      {edge_list, _} = outlist[0]
      assert edge_list[0][:ref] == {0,3}
      assert edge_list[0][:attributes] == %{}

      inlist = g.graph.inlist
      {edge_list, _} = inlist[3]
      assert edge_list[0][:ref] == {0,3}
      assert edge_list[0][:attributes] == %{}
    end

    test "remove_edge", %{adj_list: graph} do
      g_with_vertices = Graph.add_vertex(graph, @elements[:lefkosia])
      |>  Graph.add_vertex(@elements[:lemesos])
      |>  Graph.add_vertex(@elements[:larnaca])
      |>  Graph.add_vertex(@elements[:paphos])
      |>  Graph.add_edge(0, 2)
      |>  Graph.add_edge(2, 3)

      g = Graph.remove_edge(g_with_vertices, 0, 2)

      {edges, _} = g.graph.outlist[0]
      assert !Enum.any?(edges, fn(edge) ->
        edge.ref == {0, 2}
      end)

      {edges, _} = g.graph.inlist[2]
      assert !Enum.any?(edges, fn(edge) ->
        edge.ref == {0, 2}
      end)
    end

    test "has_edge", %{adj_list: graph} do
      g = Graph.add_vertex(graph, @elements[:lefkosia])
      |>  Graph.add_vertex(@elements[:lemesos])
      |>  Graph.add_vertex(@elements[:larnaca])
      |>  Graph.add_vertex(@elements[:paphos])
      |>  Graph.add_edge(0, 2)
      |>  Graph.add_edge(2, 3)
      |>  Graph.add_edge(1, 3)

      assert Graph.has_edge(g, 0,2)
      assert Graph.has_edge(g, 2,3)
      assert Graph.has_edge(g, 1,3)
      assert !Graph.has_edge(g, 0,1)
    end

    test "out_edges", %{adj_list: graph} do
      g = Graph.add_vertex(graph, @elements[:lefkosia])
      |>  Graph.add_vertex(@elements[:lemesos])
      |>  Graph.add_vertex(@elements[:larnaca])
      |>  Graph.add_vertex(@elements[:paphos])
      |>  Graph.add_edge(0, 1)
      |>  Graph.add_edge(0, 2)
      |>  Graph.add_edge(1, 3)

      assert Enum.map(Graph.out_edges(g, 0), fn(edge) ->
        edge.ref
      end) == [{0,1}, {0,2}]
    end

    test "in_edges", %{adj_list: graph} do
      g = Graph.add_vertex(graph, @elements[:lefkosia])
      |>  Graph.add_vertex(@elements[:lemesos])
      |>  Graph.add_vertex(@elements[:larnaca])
      |>  Graph.add_vertex(@elements[:paphos])
      |>  Graph.add_edge(0, 1)
      |>  Graph.add_edge(0, 2)
      |>  Graph.add_edge(1, 3)
      |>  Graph.add_edge(3, 0)

      assert Enum.map(Graph.in_edges(g, 0), fn(edge) ->
        edge.ref
      end) == [{3,0}]
    end
  end
end
