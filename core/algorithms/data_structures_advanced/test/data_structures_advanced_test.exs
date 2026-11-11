defmodule DataStructuresAdvancedTest do
  use ExUnit.Case

  alias DataStructuresAdvanced.{BinaryTree, Graph, TreeNode}

  # Casos de la especificación 07_Data_Structures_Advanced.md: 24 casos
  # (TreeNode 6, BinaryTree 7, Graph 11); cada fila de la tabla es un test.
  #
  # Elixir es inmutable: cada operación devuelve una instancia nueva y el
  # escenario continúa con lo que devuelve la operación precedente. La ausencia
  # es `nil` (enlaces de nodo y vecinos de un vértice inexistente); una
  # secuencia de vecinos vacía es `[]`, distinta del fallo.

  @parent_value 10
  @left_value 20
  @right_value 30
  @absent_value 99

  # Valores del ABB.
  @root_value 50
  @lower_value 30
  @higher_value 70
  @deep_low_value 20
  @deep_mid_value 40

  # Etiquetas del grafo.
  @label_a 10
  @label_b 30
  @label_c 50
  @label_d 70
  @missing_label 99
  @other_missing_label 98

  # Las operaciones del contrato devuelven `{éxito, estructura}`; el paso
  # desestructura el par y conserva la estructura aunque el éxito sea `false`.
  defp step({ok, next}, _previous), do: {ok, next}

  defp insert_all(tree, values) do
    Enum.reduce(values, tree, fn value, acc ->
      {ok, next} = step(BinaryTree.insert(acc, value), acc)
      assert ok == true, "BinaryTree insert(#{value}) should succeed"
      next
    end)
  end

  defp register_all(graph, labels) do
    Enum.reduce(labels, graph, fn label, acc ->
      {ok, next} = step(Graph.add_vertex(acc, label), acc)
      assert ok == true, "Graph add_vertex(#{label}) should succeed"
      next
    end)
  end

  defp connect(graph, source, target) do
    {ok, next} = step(Graph.add_edge(graph, source, target), graph)
    assert ok == true, "Graph add_edge(#{source}, #{target}) should succeed"
    next
  end

  defp reject_edge(graph, source, target) do
    {ok, next} = step(Graph.add_edge(graph, source, target), graph)
    assert ok == false, "Graph add_edge(#{source}, #{target}) should fail"
    next
  end

  defp assert_counts(graph, vertices, edges) do
    assert Graph.vertex_count(graph) == vertices,
           "Graph should have #{vertices} vertices"

    assert Graph.edge_count(graph) == edges,
           "Graph should have #{edges} edges"
  end

  describe "TreeNode" do
    test "Crear un nodo de árbol" do
      node = TreeNode.new(@parent_value)

      assert TreeNode.value(node) == @parent_value,
             "TreeNode init should assign the value"
    end

    test "Enlaces iniciales ausentes" do
      node = TreeNode.new(@parent_value)

      assert TreeNode.left(node) == nil,
             "TreeNode init should leave the left link absent"

      assert TreeNode.right(node) == nil,
             "TreeNode init should leave the right link absent"
    end

    test "Enlazar dos hijos" do
      parent =
        TreeNode.new(@parent_value)
        |> TreeNode.put_left(TreeNode.new(@left_value))
        |> TreeNode.put_right(TreeNode.new(@right_value))

      assert TreeNode.value(TreeNode.left(parent)) == @left_value,
             "TreeNode set_left should link the left child 20"

      assert TreeNode.value(TreeNode.right(parent)) == @right_value,
             "TreeNode set_right should link the right child 30"
    end

    test "Recorrer cada enlace" do
      parent =
        TreeNode.new(@parent_value)
        |> TreeNode.put_left(TreeNode.new(@left_value))
        |> TreeNode.put_right(TreeNode.new(@right_value))

      left = TreeNode.left(parent)
      right = TreeNode.right(parent)

      assert TreeNode.value(left) == @left_value,
             "the left link should lead to 20"

      assert TreeNode.value(right) == @right_value,
             "the right link should lead to 30"

      assert TreeNode.left(left) == nil and TreeNode.right(left) == nil,
             "the left child's links should be absent"

      assert TreeNode.left(right) == nil and TreeNode.right(right) == nil,
             "the right child's links should be absent"
    end

    test "Desenlazar hijos" do
      linked =
        TreeNode.new(@parent_value)
        |> TreeNode.put_left(TreeNode.new(@left_value))
        |> TreeNode.put_right(TreeNode.new(@right_value))

      without_left = TreeNode.put_left(linked, nil)

      assert TreeNode.left(without_left) == nil,
             "clearing the left link should leave it absent"

      assert TreeNode.value(without_left) == @parent_value,
             "clearing the left link should preserve the value 10"

      assert TreeNode.value(TreeNode.right(without_left)) == @right_value,
             "clearing the left link should preserve the right child 30"

      without_both = TreeNode.put_right(without_left, nil)

      assert TreeNode.left(without_both) == nil and TreeNode.right(without_both) == nil,
             "clearing the right link should leave both links absent"

      assert TreeNode.value(without_both) == @parent_value,
             "clearing both links should preserve the value 10"
    end

    test "Adaptación inmutable" do
      original = TreeNode.new(@parent_value)
      updated = TreeNode.put_left(original, TreeNode.new(@left_value))

      assert TreeNode.value(TreeNode.left(updated)) == @left_value,
             "TreeNode set_left should return a new node with the link"

      assert TreeNode.left(original) == nil,
             "TreeNode set_left should leave the original node unchanged"
    end
  end

  describe "BinaryTree" do
    test "Crear vacío" do
      tree = BinaryTree.new()

      assert BinaryTree.empty?(tree) == true, "BinaryTree should be empty after init"
      assert BinaryTree.size(tree) == 0, "BinaryTree should start with size 0"

      assert BinaryTree.contains?(tree, @root_value) == false,
             "BinaryTree contains(50) should fail on an empty tree"
    end

    test "Insertar la raíz" do
      tree = insert_all(BinaryTree.new(), [@root_value])

      assert BinaryTree.size(tree) == 1, "BinaryTree should have size 1 after the root"
      assert BinaryTree.empty?(tree) == false, "BinaryTree should not be empty after the root"

      assert BinaryTree.contains?(tree, @root_value) == true,
             "BinaryTree should contain the root 50"
    end

    test "Insertar menor y mayor" do
      values = [@root_value, @lower_value, @higher_value]
      tree = insert_all(BinaryTree.new(), values)

      assert BinaryTree.size(tree) == 3, "BinaryTree should have size 3"

      for value <- values do
        assert BinaryTree.contains?(tree, value) == true,
               "BinaryTree should contain #{value}"
      end
    end

    test "Ramas de varios niveles" do
      values = [@root_value, @lower_value, @higher_value, @deep_low_value, @deep_mid_value]
      tree = insert_all(BinaryTree.new(), values)

      for value <- values do
        assert BinaryTree.contains?(tree, value) == true,
               "BinaryTree should contain #{value}"
      end

      assert BinaryTree.size(tree) == 5, "BinaryTree should have size 5"
    end

    test "Valor ausente en árbol no vacío" do
      tree = insert_all(BinaryTree.new(), [@root_value])

      assert BinaryTree.contains?(tree, @absent_value) == false,
             "BinaryTree contains(99) should fail on a nonempty tree"

      assert BinaryTree.size(tree) == 1,
             "BinaryTree should keep size 1 after a failed lookup"

      assert BinaryTree.contains?(tree, @root_value) == true,
             "BinaryTree should still contain 50 after a failed lookup"
    end

    test "Duplicado idempotente" do
      values = [@root_value, @lower_value, @higher_value]
      tree = insert_all(BinaryTree.new(), values ++ [@lower_value])

      assert BinaryTree.size(tree) == 3,
             "BinaryTree should ignore a duplicate and keep size 3"

      for value <- values do
        assert BinaryTree.contains?(tree, value) == true,
               "BinaryTree should preserve #{value} after the duplicate"
      end
    end

    test "Inserciones ordenadas" do
      values = [@deep_low_value, @right_value, @deep_mid_value, @root_value, @higher_value]
      tree = insert_all(BinaryTree.new(), values)

      assert BinaryTree.size(tree) == 5, "BinaryTree should have size 5"

      for value <- values do
        assert BinaryTree.contains?(tree, value) == true,
               "BinaryTree should contain #{value}"
      end

      assert BinaryTree.contains?(tree, @absent_value) == false,
             "BinaryTree contains(99) should fail after ordered insertions"
    end
  end

  describe "Graph" do
    test "Crear vacío" do
      graph = Graph.new()

      assert Graph.empty?(graph) == true, "Graph should be empty after init"
      assert_counts(graph, 0, 0)

      assert Graph.has_edge?(graph, @label_a, @label_b) == false,
             "Graph has_edge(10, 30) should fail on an empty graph"

      assert Graph.get_neighbors(graph, @label_a) == nil,
             "Graph get_neighbors(10) should fail on an empty graph"
    end

    test "Vértice aislado" do
      graph = register_all(Graph.new(), [@label_a])

      assert Graph.empty?(graph) == false, "Graph should not be empty after add_vertex"
      assert_counts(graph, 1, 0)

      assert Graph.get_neighbors(graph, @label_a) == [],
             "Graph should give an isolated vertex empty neighbours"
    end

    test "Etiquetas no consecutivas y arista dirigida" do
      graph =
        Graph.new()
        |> register_all([@label_a, @label_d])
        |> connect(@label_a, @label_d)

      assert Graph.has_edge?(graph, @label_a, @label_d) == true,
             "Graph should have the forward edge 10 -> 70"

      assert Graph.has_edge?(graph, @label_d, @label_a) == false,
             "Graph should not have the reverse edge 70 -> 10"

      assert_counts(graph, 2, 1)
    end

    test "Vértice duplicado conserva adyacencia" do
      graph =
        Graph.new()
        |> register_all([@label_a, @label_b])
        |> connect(@label_a, @label_b)
        |> register_all([@label_a])

      assert_counts(graph, 2, 1)

      assert Graph.get_neighbors(graph, @label_a) == [@label_b],
             "Graph should preserve the neighbours of 10 after a duplicate vertex"
    end

    test "Arista duplicada" do
      graph =
        Graph.new()
        |> register_all([@label_a, @label_b])
        |> connect(@label_a, @label_b)
        |> connect(@label_a, @label_b)

      assert_counts(graph, 2, 1)

      assert Graph.get_neighbors(graph, @label_a) == [@label_b],
             "Graph should keep a single neighbour after a duplicate edge"
    end

    test "Extremo inexistente sin mutación" do
      graph =
        Graph.new()
        |> register_all([@label_a, @label_b])
        |> connect(@label_a, @label_b)
        |> reject_edge(@label_a, @missing_label)
        |> reject_edge(@missing_label, @label_a)
        |> reject_edge(@other_missing_label, @missing_label)
        |> reject_edge(@missing_label, @missing_label)

      assert_counts(graph, 2, 1)

      assert Graph.get_neighbors(graph, @label_a) == [@label_b],
             "Graph should preserve the neighbours of 10 after rejected edges"

      assert Graph.get_neighbors(graph, @label_b) == [],
             "Graph should leave 30 without neighbours after rejected edges"

      assert Graph.has_edge?(graph, @label_a, @missing_label) == false,
             "Graph should not have the rejected edge 10 -> 99"

      assert Graph.has_edge?(graph, @missing_label, @label_a) == false,
             "Graph should not have the rejected edge 99 -> 10"

      assert Graph.has_edge?(graph, @other_missing_label, @missing_label) == false,
             "Graph should not have the rejected edge 98 -> 99"

      assert Graph.has_edge?(graph, @missing_label, @missing_label) == false,
             "Graph should not have the rejected edge 99 -> 99"

      assert Graph.get_neighbors(graph, @other_missing_label) == nil,
             "Graph get_neighbors(98) should fail for a missing vertex"

      assert Graph.get_neighbors(graph, @missing_label) == nil,
             "Graph get_neighbors(99) should fail for a missing vertex"
    end

    test "Vecinos ordenados y contadores" do
      graph =
        Graph.new()
        |> register_all([@label_a, @label_b, @label_c, @label_d])
        |> connect(@label_a, @label_d)
        |> connect(@label_a, @label_b)
        |> connect(@label_a, @label_c)
        |> connect(@label_b, @label_c)

      assert Graph.get_neighbors(graph, @label_a) == [@label_b, @label_c, @label_d],
             "Graph should list the neighbours of 10 in ascending order"

      assert Graph.get_neighbors(graph, @label_b) == [@label_c],
             "Graph should list 50 as the only neighbour of 30"

      assert Graph.get_neighbors(graph, @label_c) == [],
             "Graph should give 50 empty neighbours"

      assert Graph.get_neighbors(graph, @label_d) == [],
             "Graph should give 70 empty neighbours"

      assert_counts(graph, 4, 4)
    end

    test "Consulta de arista ausente" do
      graph = register_all(Graph.new(), [@label_a, @label_b])

      assert Graph.has_edge?(graph, @label_a, @label_b) == false,
             "Graph has_edge(10, 30) should fail when no edge was added"

      assert_counts(graph, 2, 0)
      assert Graph.empty?(graph) == false, "Graph should not be empty with two vertices"
    end

    test "Vecinos de vértice inexistente" do
      graph = register_all(Graph.new(), [@label_a])

      assert Graph.get_neighbors(graph, @missing_label) == nil,
             "Graph get_neighbors(99) should fail for a missing vertex"

      assert Graph.get_neighbors(graph, @label_a) == [],
             "Graph failure should differ from the empty neighbours of 10"

      assert_counts(graph, 1, 0)
    end

    test "Bucle y duplicado" do
      graph =
        Graph.new()
        |> register_all([@label_a])
        |> connect(@label_a, @label_a)
        |> connect(@label_a, @label_a)

      assert Graph.has_edge?(graph, @label_a, @label_a) == true,
             "Graph should have the self-loop 10 -> 10"

      assert Graph.get_neighbors(graph, @label_a) == [@label_a],
             "Graph should list 10 once as its own neighbour"

      assert_counts(graph, 1, 1)
    end

    test "Aislamiento del resultado de vecinos" do
      graph =
        Graph.new()
        |> register_all([@label_a, @label_b, @label_c])
        |> connect(@label_a, @label_b)

      saved = Graph.get_neighbors(graph, @label_a)

      assert saved == [@label_b],
             "Graph should return [30] as the neighbours of 10"

      # Elixir es inmutable: no hay copia mutable que alterar, así que la parte
      # representable del caso es que el resultado guardado no cambia después.
      updated = connect(graph, @label_a, @label_c)

      assert saved == [@label_b],
             "Graph should keep the saved result unchanged after a later edge"

      assert Graph.get_neighbors(updated, @label_a) == [@label_b, @label_c],
             "Graph should list [30, 50] for 10 after the later edge"

      assert_counts(updated, 3, 2)
    end
  end
end
