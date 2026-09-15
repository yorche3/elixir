defmodule NaiveSortTest do
  use ExUnit.Case

  # Casos de prueba de la especificación 05_Naive_Sort.md
  @standard_input [5, 2, 9, 1, 5, 6]
  @standard_output [1, 2, 5, 5, 6, 9]

  @sorted_input [1, 2, 3, 4, 5]
  @sorted_output [1, 2, 3, 4, 5]

  @reverse_input [5, 4, 3, 2, 1]
  @reverse_output [1, 2, 3, 4, 5]

  @identical_input [7, 7, 7, 7]
  @identical_output [7, 7, 7, 7]

  @negative_input [3, -1, 4, -5, 0]
  @negative_output [-5, -1, 0, 3, 4]

  @single_input [42]
  @single_output [42]

  @empty_input []
  @empty_output []

  @cases [
    {"an unsorted array", @standard_input, @standard_output},
    {"an already sorted array", @sorted_input, @sorted_output},
    {"a reverse ordered array", @reverse_input, @reverse_output},
    {"an array of identical elements", @identical_input, @identical_output},
    {"an array with negative numbers", @negative_input, @negative_output},
    {"a single element array", @single_input, @single_output},
    {"an empty array", @empty_input, @empty_output}
  ]

  # Las listas de Elixir son inmutables: no hace falta copiar los fixtures porque
  # ninguna función puede mutarlos entre casos.
  defp assert_sorts_all_cases(sort_function, algorithm) do
    Enum.each(@cases, fn {description, input, expected} ->
      assert sort_function.(input) == expected,
             "#{algorithm} should sort #{description}"
    end)

    assert sort_function.(nil) == nil,
           "#{algorithm} should return the failure indicator for a nil input"
  end

  test "Selection sort" do
    assert_sorts_all_cases(&NaiveSort.selection_sort/1, "selection_sort")
  end

  test "Bubble sort" do
    assert_sorts_all_cases(&NaiveSort.bubble_sort/1, "bubble_sort")
  end

  test "Insertion sort" do
    assert_sorts_all_cases(&NaiveSort.insertion_sort/1, "insertion_sort")
  end
end
