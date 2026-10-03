defmodule DataStructuresBasicsTest do
  use ExUnit.Case

  # Los cuatro tipos del contrato viven dentro del módulo del proyecto.
  alias DataStructuresBasics.{Cell, LinkedList, Queue, Stack}

  # Casos de prueba de la especificación 06_Data_Structures_Basics.md: 15 casos
  # (Node 2, LinkedList 5, Stack 4, Queue 4) en cuatro escenarios.
  #
  # Elixir es inmutable: cada operación devuelve una instancia nueva, así que el
  # escenario continúa con lo que devuelve la operación precedente. Los valores
  # son enteros positivos para no colisionar con el indicador de fallo (`-1`).

  @first_value 10
  @second_value 20
  @third_value 30
  @head_value 5
  @absent_value 99
  @reused_value 40
  # Indicador de fallo del contrato: lo devuelven las operaciones de valor entero
  # (`head_value`, `peek`, `pop`, `dequeue`) cuando la estructura está vacía.
  @failure_value -1

  # Recorrido del enlace de nodos: `Cell.value/1` y `Cell.next/1` son el
  # `get_value` y el `get_next` del contrato. La lista se recorre desde su cabeza.
  defp traverse(nil), do: []
  defp traverse(cell), do: [Cell.value(cell) | traverse(Cell.next(cell))]

  test "Node" do
    # Caso: inicializar y observar valor/enlace.
    a = Cell.new(@first_value)
    assert Cell.value(a) == @first_value, "Node init should assign the value"
    assert Cell.next(a) == nil, "Node init should leave the next link absent"

    # Caso: inicializar otro nodo, enlazar y recorrer.
    b = Cell.new(@second_value)
    linked = Cell.put_next(a, b)

    assert Cell.value(Cell.next(linked)) == @second_value,
           "Node set_next should link the next node"

    assert Cell.next(b) == nil,
           "a linked node should keep its next link absent"
  end

  test "LinkedList" do
    # Caso: estado vacío.
    list = LinkedList.new()
    assert LinkedList.empty?(list) == true, "LinkedList should be empty after init"
    assert LinkedList.size(list) == 0, "LinkedList should start with size 0"

    assert LinkedList.head_value(list) == @failure_value,
           "LinkedList get_head should return the failure indicator on an empty list"

    # Caso: insertar por ambos extremos.
    list =
      list
      |> LinkedList.insert_tail(@first_value)
      |> LinkedList.insert_tail(@second_value)
      |> LinkedList.insert_head(@head_value)
      |> LinkedList.insert_tail(@first_value)

    assert LinkedList.size(list) == 4,
           "LinkedList should count one element per insertion"

    assert traverse(list.head) == [5, 10, 20, 10],
           "LinkedList should traverse 5, 10, 20, 10 from the head"

    # Caso: eliminar la primera aparición.
    {deleted, list} = LinkedList.delete(list, @first_value)
    assert deleted == true, "LinkedList delete should succeed on the first occurrence"

    assert traverse(list.head) == [5, 20, 10],
           "LinkedList delete should remove only the first occurrence"

    assert LinkedList.size(list) == 3,
           "LinkedList delete should decrement the size on success"

    # Caso: valor ausente.
    {deleted, list} = LinkedList.delete(list, @absent_value)
    assert deleted == false, "LinkedList delete should fail on an absent value"

    assert traverse(list.head) == [5, 20, 10],
           "a failed LinkedList delete should keep the elements"

    assert LinkedList.size(list) == 3,
           "a failed LinkedList delete should keep the size"

    # Caso: vaciar la lista.
    {head_deleted, list} = LinkedList.delete(list, @head_value)
    {second_deleted, list} = LinkedList.delete(list, @second_value)
    {last_deleted, list} = LinkedList.delete(list, @first_value)

    assert head_deleted == true, "LinkedList delete should remove the remaining head"
    assert second_deleted == true, "LinkedList delete should remove the second value"
    assert last_deleted == true, "LinkedList delete should remove the last value"

    assert LinkedList.empty?(list) == true,
           "LinkedList should be empty after deleting every element"

    assert LinkedList.size(list) == 0,
           "LinkedList should report size 0 after deleting every element"

    assert LinkedList.head_value(list) == @failure_value,
           "LinkedList get_head should return the failure indicator once empty"
  end

  test "Stack" do
    # Caso: estado vacío y extracción fallida.
    stack = Stack.new()
    assert Stack.empty?(stack) == true, "Stack should be empty after init"
    assert Stack.size(stack) == 0, "Stack should start with size 0"

    assert Stack.peek(stack) == @failure_value,
           "Stack peek should return the failure indicator on an empty stack"

    {failed_pop, _stack} = Stack.pop(stack)

    assert failed_pop == @failure_value,
           "Stack pop should return the failure indicator on an empty stack"

    # Caso: LIFO y peek no mutante.
    stack =
      stack
      |> Stack.push(@first_value)
      |> Stack.push(@second_value)
      |> Stack.push(@third_value)

    assert Stack.peek(stack) == @third_value,
           "Stack peek should observe the most recent value without removing it"

    assert Stack.size(stack) == 3, "Stack peek should not change the size"

    # Caso: extracción y reutilización.
    {popped, stack} = Stack.pop(stack)
    assert popped == @third_value, "Stack pop should remove the most recent value first"

    stack = Stack.push(stack, @reused_value)
    {popped, stack} = Stack.pop(stack)
    assert popped == @reused_value, "Stack pop should remove the reused value next"

    {popped, stack} = Stack.pop(stack)
    assert popped == @second_value, "Stack pop should continue in LIFO order"

    {popped, stack} = Stack.pop(stack)
    assert popped == @first_value, "Stack pop should remove the oldest value last"

    assert Stack.empty?(stack) == true, "Stack should be empty after popping every value"
    assert Stack.size(stack) == 0, "Stack should report size 0 after popping every value"

    # Caso: vacío tras extracción.
    {popped, stack} = Stack.pop(stack)
    assert popped == @failure_value, "Stack pop should keep failing once empty"
    assert Stack.empty?(stack) == true, "Stack should stay empty after a failed pop"
  end

  test "Queue" do
    # Caso: estado vacío y extracción fallida.
    queue = Queue.new()
    assert Queue.empty?(queue) == true, "Queue should be empty after init"
    assert Queue.size(queue) == 0, "Queue should start with size 0"

    assert Queue.peek(queue) == @failure_value,
           "Queue peek should return the failure indicator on an empty queue"

    {failed_dequeue, _queue} = Queue.dequeue(queue)

    assert failed_dequeue == @failure_value,
           "Queue dequeue should return the failure indicator on an empty queue"

    # Caso: FIFO y peek no mutante.
    queue =
      queue
      |> Queue.enqueue(@first_value)
      |> Queue.enqueue(@second_value)
      |> Queue.enqueue(@third_value)

    assert Queue.peek(queue) == @first_value,
           "Queue peek should observe the oldest value without removing it"

    assert Queue.size(queue) == 3, "Queue peek should not change the size"

    # Caso: extracción y reutilización.
    {dequeued, queue} = Queue.dequeue(queue)
    assert dequeued == @first_value, "Queue dequeue should remove the oldest value first"

    queue = Queue.enqueue(queue, @reused_value)

    {dequeued, queue} = Queue.dequeue(queue)
    assert dequeued == @second_value, "Queue dequeue should continue in FIFO order"

    {dequeued, queue} = Queue.dequeue(queue)
    assert dequeued == @third_value, "Queue dequeue should return the third value next"

    {dequeued, queue} = Queue.dequeue(queue)
    assert dequeued == @reused_value, "Queue dequeue should return the reused value last"

    assert Queue.empty?(queue) == true, "Queue should be empty after dequeuing every value"
    assert Queue.size(queue) == 0, "Queue should report size 0 after dequeuing every value"

    # Caso: vacío tras extracción.
    {dequeued, queue} = Queue.dequeue(queue)
    assert dequeued == @failure_value, "Queue dequeue should keep failing once empty"
    assert Queue.empty?(queue) == true, "Queue should stay empty after a failed dequeue"
  end
end
