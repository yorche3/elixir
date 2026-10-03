defmodule DataStructuresBasics do
end

defmodule Cell do
  defstruct value: nil, next: nil
  @type t :: %__MODULE__{
    value: integer,
    next: t | nil }

  @spec new(value :: integer) :: t

  @spec value(node :: t) :: integer

  @spec next(node :: t) :: t | nil

  @spec put_next(node :: t, next :: t | nil) :: t


end

defmodule LinkedList do
  defstruct head: nil, tail: nil, count: 0
  @type t :: %__MODULE__{
    head: Cell.t | nil,
    tail: Cell.t | nil,
    count: non_neg_integer }

  @spec new(
    head :: Cell.t | nil,
    tail :: Cell.t | nil,
    count :: non_neg_integer) :: t

  @spec empty?(list :: t) :: boolean
  @spec size(list :: t) :: non_neg_integer

  @spec head_value(list :: t) :: integer
  @spec insert_head(list :: t, value :: integer) :: t
  @spec insert_tail(list :: t, value :: integer) :: t
  @spec delete(list :: t, value :: integer) :: {boolean, t}
end

defmodule Stack do
  defstruct top: nil, count: 0
  @type t :: %__MODULE__{
    top: Cell.t | nil,
    count: non_neg_integer
  }

  @spec new(top :: Cell.t | nil, count :: non_neg_integer) :: t
  @spec empty?(stack :: t) :: boolean
  @spec size(stack :: t) :: non_neg_integer
  @spec push(stack :: t, value :: integer) :: t
  @spec peek(stack :: t) :: integer
  @spec pop(stack :: t) :: {integer | nil, t}
end

defmodule Queue do
  defstruct front: nil, rear: nil, count: 0
  @type t :: %__MODULE__{
    front: Cell.t | nil,
    rear: Cell.t | nil,
    count: non_neg_integer
  }

  @spec new(front :: Cell.t | nil, rear :: Cell.t | nil, count :: non_neg_integer) :: t
  @spec empty?(queue :: t) :: boolean
  @spec size(queue :: t) :: non_neg_integer
  @spec enqueue(queue :: t, value :: integer) :: t
  @spec peek(queue :: t) :: integer
  @spec dequeue(queue :: t) :: {integer | nil, t}
end
