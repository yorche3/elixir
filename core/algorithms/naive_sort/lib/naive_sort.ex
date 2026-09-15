defmodule NaiveSort do
  # Selection Sort implementation
  # Input: An int array
  # Output: A sorted int array
  def selection_sort(nil), do: nil
  def selection_sort([]), do: []
  def selection_sort([a]), do: [a]

  def selection_sort(list) do
    {min, rest} = pick_min(list)
    [min | selection_sort(rest)]
  end

  # Helper function to pick the minimum element from a list and return it along with the rest of the list
  defp pick_min([head | tail]) do
    pick_min(tail, head, [])
  end

  defp pick_min([], min, rest), do: {min, rest}
  defp pick_min([h | t], min, rest) when h < min, do: pick_min(t, h, [min | rest])
  defp pick_min([h | t], min, rest), do: pick_min(t, min, [h | rest])

  # Bubble Sort implementation
  # Input: An int array
  # Output: A sorted int array
  def bubble_sort(nil), do: nil
  def bubble_sort([]), do: []
  def bubble_sort([a]), do: [a]

  def bubble_sort(list) do
    case bubble_pass(list) do
      {false, sorted} -> sorted
      {true, partially_sorted} -> bubble_sort(partially_sorted)
    end
  end

  # Helper function to perform a single pass of bubble sort on a list
  # Returns a tuple {swapped, list} where swapped is true if any elements were swapped during the pass
  defp bubble_pass([a, b | tail]) when a > b do
    {_swapped, rest} = bubble_pass([a | tail])
    {true, [b | rest]}
  end

  defp bubble_pass([a, b | tail]) do
    {swapped, rest} = bubble_pass([b | tail])
    {swapped, [a | rest]}
  end

  defp bubble_pass(list), do: {false, list}

  # Insertion Sort implementation
  # Input: An int array
  # Output: A sorted int array
  def insertion_sort(nil), do: nil
  def insertion_sort([]), do: []
  def insertion_sort([a]), do: [a]

  def insertion_sort([head | tail]) do
    insert(head, insertion_sort(tail))
  end

  # Helper function to insert an element into a sorted list
  defp insert(x, []), do: [x]
  defp insert(x, [h | t]) when x <= h, do: [x | [h | t]]
  defp insert(x, [h | t]), do: [h | insert(x, t)]
end
