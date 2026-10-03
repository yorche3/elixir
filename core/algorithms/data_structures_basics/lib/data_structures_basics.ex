defmodule DataStructuresBasics do
  defmodule Cell do
    defstruct value: nil, next: nil

    @type t :: %__MODULE__{
            value: integer,
            next: t | nil
          }

    @spec new(value :: integer) :: t
    def new(value) do
      %__MODULE__{value: value, next: nil}
    end

    @spec value(node :: t) :: integer
    def value(%__MODULE__{value: value}), do: value

    @spec next(node :: t) :: t | nil
    def next(%__MODULE__{next: next}), do: next

    @spec put_next(node :: t, next :: t | nil) :: t
    def put_next(%__MODULE__{} = node, next) do
      %__MODULE__{node | next: next}
    end
  end

  defmodule LinkedList do
    # El indicador de fallo es del contrato y los atributos no se heredan entre
    # módulos anidados: se declara donde se usa.
    @failure_value -1

    defstruct head: nil, tail: nil, count: 0

    @type t :: %__MODULE__{
            head: Cell.t() | nil,
            tail: Cell.t() | nil,
            count: non_neg_integer
          }

    @spec new() :: t
    def new() do
      %__MODULE__{head: nil, tail: nil, count: 0}
    end

    @spec empty?(list :: t) :: boolean
    def empty?(%__MODULE__{count: 0}), do: true
    def empty?(_list), do: false

    @spec size(list :: t) :: non_neg_integer
    def size(%__MODULE__{count: count}), do: count

    @spec head_value(list :: t) :: integer
    def head_value(%__MODULE__{head: %Cell{value: value}}), do: value
    def head_value(_list), do: @failure_value
    @spec insert_head(list :: t, value :: integer) :: t
    def insert_head(%__MODULE__{} = list, value) do
      new_head = Cell.new(value)

      case list.head do
        nil ->
          %__MODULE__{list | head: new_head, tail: new_head, count: 1}

        _ ->
          new_head = Cell.put_next(new_head, list.head)
          %__MODULE__{list | head: new_head, count: list.count + 1}
      end
    end

    @spec insert_tail(list :: t, value :: integer) :: t
    def insert_tail(%__MODULE__{} = list, value) do
      new_tail = Cell.new(value)

      case list.head do
        nil ->
          %__MODULE__{list | head: new_tail, tail: new_tail, count: 1}

        _ ->
          %__MODULE__{
            list
            | head: append_cell(list.head, new_tail),
              tail: new_tail,
              count: list.count + 1
          }
      end
    end

    defp append_cell(nil, new_cell), do: new_cell
    defp append_cell(%Cell{next: nil} = cell, new_cell), do: Cell.put_next(cell, new_cell)

    defp append_cell(%Cell{next: next} = cell, new_cell),
      do: Cell.put_next(cell, append_cell(next, new_cell))

    @spec delete(list :: t, value :: integer) :: {boolean, t}
    def delete(%__MODULE__{} = list, value) do
      case remove_cell(list.head, value) do
        {0, _} -> {false, list}
        {1, new_head} -> {true, %__MODULE__{list | head: new_head, count: list.count - 1}}
      end
    end

    defp remove_cell(nil, _value), do: {0, nil}

    defp remove_cell(%Cell{value: cell_value, next: next}, value) when cell_value == value,
      do: {1, next}

    defp remove_cell(%Cell{next: next} = cell, value) do
      case remove_cell(next, value) do
        {0, _} -> {0, cell}
        {1, new_next} -> {1, Cell.put_next(cell, new_next)}
      end
    end
  end

  defmodule Stack do
    @failure_value -1

    defstruct top: nil, count: 0

    @type t :: %__MODULE__{
            top: Cell.t() | nil,
            count: non_neg_integer
          }

    @spec new() :: t
    def new() do
      %__MODULE__{top: nil, count: 0}
    end

    @spec empty?(stack :: t) :: boolean
    def empty?(%__MODULE__{top: nil}), do: true
    def empty?(%__MODULE__{}), do: false
    @spec size(stack :: t) :: non_neg_integer
    def size(%__MODULE__{count: count}), do: count
    @spec push(stack :: t, value :: integer) :: t
    def push(%__MODULE__{} = stack, value) do
      new_top = Cell.new(value)
      new_top = Cell.put_next(new_top, stack.top)
      %__MODULE__{stack | top: new_top, count: stack.count + 1}
    end

    @spec peek(stack :: t) :: integer
    def peek(%__MODULE__{top: nil}), do: @failure_value
    def peek(%__MODULE__{top: top}), do: Cell.value(top)
    @spec pop(stack :: t) :: {integer, t}
    def pop(%__MODULE__{top: nil} = stack), do: {@failure_value, stack}

    def pop(%__MODULE__{} = stack) do
      value = Cell.value(stack.top)
      new_top = Cell.next(stack.top)
      {value, %__MODULE__{stack | top: new_top, count: stack.count - 1}}
    end
  end

  defmodule Queue do
    @failure_value -1

    defstruct front: nil, rear: nil, count: 0

    @type t :: %__MODULE__{
            front: Cell.t() | nil,
            rear: Cell.t() | nil,
            count: non_neg_integer
          }

    @spec new() :: t
    def new() do
      %__MODULE__{front: nil, rear: nil, count: 0}
    end

    @spec empty?(queue :: t) :: boolean
    def empty?(%__MODULE__{front: nil}), do: true
    def empty?(%__MODULE__{}), do: false
    @spec size(queue :: t) :: non_neg_integer
    def size(%__MODULE__{count: count}), do: count

    @spec enqueue(queue :: t, value :: integer) :: t
    def enqueue(%__MODULE__{front: nil} = queue, value) do
      new_cell = Cell.new(value)
      %__MODULE__{queue | front: new_cell, rear: new_cell, count: 1}
    end

    def enqueue(%__MODULE__{front: first, rear: _, count: n} = queue, value) do
      new_node = Cell.new(value)
      new_front = append_last(first, new_node)
      %__MODULE__{queue | front: new_front, rear: new_node, count: n + 1}
    end

    defp append_last(%Cell{value: _, next: nil} = first, new_node) do
      new_first = Cell.put_next(first, new_node)
      new_first
    end

    defp append_last(%Cell{value: _, next: next} = first, new_node) do
      new_next = append_last(next, new_node)
      Cell.put_next(first, new_next)
    end

    @spec peek(queue :: t) :: integer
    def peek(%__MODULE__{front: nil}), do: @failure_value
    def peek(%__MODULE__{front: front}), do: Cell.value(front)

    @spec dequeue(queue :: t) :: {integer, t}
    def dequeue(%__MODULE__{front: nil} = queue), do: {@failure_value, queue}

    def dequeue(%__MODULE__{front: %Cell{value: value, next: nil}, count: n} = queue) do
      {value, %__MODULE__{queue | front: nil, rear: nil, count: n - 1}}
    end

    def dequeue(%__MODULE__{front: %Cell{value: value, next: rest}, count: n} = queue) do
      {value, %__MODULE__{queue | front: rest, count: n - 1}}
    end
  end
end
