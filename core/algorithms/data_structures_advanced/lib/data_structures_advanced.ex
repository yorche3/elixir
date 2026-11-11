defmodule DataStructuresAdvanced do
  @moduledoc """
  Documentation for `DataStructuresAdvanced`.
  """

  defmodule TreeNode do
    defstruct value: nil, left: nil, right: nil

    @type t :: %__MODULE__{
            value: integer,
            left: t | nil,
            right: t | nil
          }

    @spec new(value :: integer) :: t
    def new(_value), do: nil

    @spec value(node :: t) :: integer
    def value(_node), do: nil

    @spec left(node :: t) :: t | nil
    def left(_node), do: nil

    @spec right(node :: t) :: t | nil
    def right(_node), do: nil

    @spec put_left(node :: t, left :: t | nil) :: t
    def put_left(_node, _left), do: nil

    @spec put_right(node :: t, right :: t | nil) :: t
    def put_right(_node, _right), do: nil
  end

  defmodule BinaryTree do
    defstruct root: nil, count: 0

    @type t :: %__MODULE__{
            root: TreeNode.t() | nil,
            count: non_neg_integer
          }

    @spec new() :: t
    def new(), do: nil

    @spec insert(tree :: t, value :: integer) :: {true, t}
    def insert(_tree, _value), do: nil

    @spec contains?(tree :: t, value :: integer) :: boolean
    def contains?(_tree, _value), do: nil

    @spec empty?(tree :: t) :: boolean
    def empty?(_tree), do: nil

    @spec size(tree :: t) :: non_neg_integer
    def size(_tree), do: nil
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
    def new(_label), do: nil
  end

  defmodule Graph do
    defstruct vertices: nil, vertex_count: 0, edge_count: 0

    @type t :: %__MODULE__{
            vertices: GraphNode.t() | nil,
            vertex_count: non_neg_integer,
            edge_count: non_neg_integer
          }

    @spec new() :: t
    def new(), do: nil

    @spec add_vertex(graph :: t, label :: integer) :: {true, t}
    def add_vertex(_graph, _label), do: nil

    @spec add_edge(graph :: t, source :: integer, target :: integer) :: {boolean, t}
    def add_edge(_graph, _source, _target), do: nil

    @spec has_edge?(graph :: t, source :: integer, target :: integer) :: boolean
    def has_edge?(_graph, _source, _target), do: nil

    @spec get_neighbors(graph :: t, label :: integer) :: [integer] | nil
    def get_neighbors(_graph, _label), do: nil

    @spec empty?(graph :: t) :: boolean
    def empty?(_graph), do: nil

    @spec vertex_count(graph :: t) :: non_neg_integer
    def vertex_count(_graph), do: nil

    @spec edge_count(graph :: t) :: non_neg_integer
    def edge_count(_graph), do: nil
  end
end
