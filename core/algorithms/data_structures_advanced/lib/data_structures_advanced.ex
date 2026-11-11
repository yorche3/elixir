defmodule DataStructuresAdvanced do
  @moduledoc """
  Modulo del contrato 07: nodo con valor, arbol binario de busqueda y grafo
  dirigido sobre estructuras inmutables.
  """

  defmodule TreeNode do
    defstruct value: nil, left: nil, right: nil

    @type t :: %__MODULE__{
            value: integer,
            left: t | nil,
            right: t | nil
          }

    @spec new(value :: integer) :: t
    def new(value), do: %__MODULE__{value: value}

    @spec value(node :: t) :: integer
    def value(%__MODULE__{value: value}), do: value

    @spec left(node :: t) :: t | nil
    def left(%__MODULE__{left: left}), do: left

    @spec right(node :: t) :: t | nil
    def right(%__MODULE__{right: right}), do: right

    @spec put_left(node :: t, left :: t | nil) :: t
    def put_left(%__MODULE__{} = node, left), do: %__MODULE__{node | left: left}

    @spec put_right(node :: t, right :: t | nil) :: t
    def put_right(%__MODULE__{} = node, right), do: %__MODULE__{node | right: right}
  end

  defmodule BinaryTree do
    defstruct root: nil, count: 0

    @type t :: %__MODULE__{
            root: TreeNode.t() | nil,
            count: non_neg_integer
          }

    @spec new() :: t
    def new(), do: %__MODULE__{}

    @spec insert(tree :: t, value :: integer) :: {boolean, t}
    def insert(%__MODULE__{} = tree, value) do
      {new_root, inserted} = insert_node(tree.root, value)
      new_count = if inserted, do: tree.count + 1, else: tree.count
      {true, %__MODULE__{tree | root: new_root, count: new_count}}
    end

    defp insert_node(nil, value), do: {TreeNode.new(value), true}

    defp insert_node(node, value) do
      cond do
        value < node.value ->
          {new_left, inserted} = insert_node(node.left, value)
          {TreeNode.put_left(node, new_left), inserted}

        value > node.value ->
          {new_right, inserted} = insert_node(node.right, value)
          {TreeNode.put_right(node, new_right), inserted}

        true ->
          {node, false}
      end
    end

    @spec contains?(tree :: t, value :: integer) :: boolean
    def contains?(%__MODULE__{} = tree, value), do: contains_node?(tree.root, value)

    defp contains_node?(nil, _value), do: false

    defp contains_node?(node, value) do
      cond do
        value < node.value -> contains_node?(node.left, value)
        value > node.value -> contains_node?(node.right, value)
        true -> true
      end
    end

    @spec empty?(tree :: t) :: boolean
    def empty?(%__MODULE__{} = tree), do: tree.count == 0

    @spec size(tree :: t) :: non_neg_integer
    def size(%__MODULE__{} = tree), do: tree.count
  end

  defmodule GraphNode do
    @moduledoc false

    defstruct value: nil, neighbors: [], next_vertex: nil

    @type t :: %__MODULE__{
            value: integer,
            neighbors: [integer],
            next_vertex: t | nil
          }

    @doc false
    @spec new(label :: integer) :: t
    def new(label), do: %__MODULE__{value: label}
  end

  defmodule Graph do
    defstruct vertices: nil, vertex_count: 0, edge_count: 0

    @type t :: %__MODULE__{
            vertices: GraphNode.t() | nil,
            vertex_count: non_neg_integer,
            edge_count: non_neg_integer
          }

    @spec new() :: t
    def new(), do: %__MODULE__{}

    @spec add_vertex(graph :: t, label :: integer) :: {true, t}
    def add_vertex(%__MODULE__{} = graph, label) do
      if find_vertex(graph.vertices, label) do
        {true, graph}
      else
        node = %{GraphNode.new(label) | next_vertex: graph.vertices}
        {true, %__MODULE__{graph | vertices: node, vertex_count: graph.vertex_count + 1}}
      end
    end

    @spec add_edge(graph :: t, source :: integer, target :: integer) :: {boolean, t}
    def add_edge(%__MODULE__{} = graph, source, target) do
      with %GraphNode{} = source_node <- find_vertex(graph.vertices, source),
           %GraphNode{} <- find_vertex(graph.vertices, target) do
        add_edge_to(graph, source_node, target)
      else
        _ -> {false, graph}
      end
    end

    defp add_edge_to(%__MODULE__{} = graph, source_node, target) do
      if target in source_node.neighbors do
        {true, graph}
      else
        neighbors = insert_sorted(source_node.neighbors, target)

        vertices =
          update_vertex(graph.vertices, source_node.value, fn node ->
            %{node | neighbors: neighbors}
          end)

        {true, %__MODULE__{graph | vertices: vertices, edge_count: graph.edge_count + 1}}
      end
    end

    @spec has_edge?(graph :: t, source :: integer, target :: integer) :: boolean
    def has_edge?(%__MODULE__{} = graph, source, target) do
      case find_vertex(graph.vertices, source) do
        nil -> false
        node -> target in node.neighbors
      end
    end

    @spec get_neighbors(graph :: t, label :: integer) :: [integer] | nil
    def get_neighbors(%__MODULE__{} = graph, label) do
      case find_vertex(graph.vertices, label) do
        nil -> nil
        node -> node.neighbors
      end
    end

    @spec empty?(graph :: t) :: boolean
    def empty?(%__MODULE__{} = graph), do: graph.vertex_count == 0

    @spec vertex_count(graph :: t) :: non_neg_integer
    def vertex_count(%__MODULE__{} = graph), do: graph.vertex_count

    @spec edge_count(graph :: t) :: non_neg_integer
    def edge_count(%__MODULE__{} = graph), do: graph.edge_count

    defp find_vertex(nil, _label), do: nil
    defp find_vertex(%GraphNode{value: label} = node, label), do: node

    defp find_vertex(%GraphNode{} = node, label),
      do: find_vertex(node.next_vertex, label)

    defp insert_sorted([], value), do: [value]
    defp insert_sorted([head | _] = list, value) when value < head, do: [value | list]

    defp insert_sorted([head | tail], value) when value > head,
      do: [head | insert_sorted(tail, value)]

    defp insert_sorted(list, _value), do: list

    defp update_vertex(nil, _label, _fun), do: nil
    defp update_vertex(%GraphNode{value: label} = node, label, fun), do: fun.(node)

    defp update_vertex(%GraphNode{} = node, label, fun) do
      %{node | next_vertex: update_vertex(node.next_vertex, label, fun)}
    end
  end
end
