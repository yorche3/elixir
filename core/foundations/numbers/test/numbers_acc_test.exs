defmodule NumbersAccTest do
  use ExUnit.Case
  doctest Numbers

  test "Sum of first n numbers Accumulator" do
    assert Numbers.sum_first_n_acc(0) == 0
    assert Numbers.sum_first_n_acc(3) == 6
  end

  test "Factorial Accumulator" do
    assert Numbers.factorial_acc(0) == 1
    assert Numbers.factorial_acc(4) == 24
  end

  test "Fibonacci Accumulator" do
    assert Numbers.fibonacci_acc(0) == 0
    assert Numbers.fibonacci_acc(1) == 1
    assert Numbers.fibonacci_acc(6) == 8
  end

  test "Greatest Common Divisor Accumulator" do
    assert Numbers.greatest_common_divisor_acc(12, 8) == 4
    assert Numbers.greatest_common_divisor_acc(7, 5) == 1
  end

  test "Least Common Multiple Accumulator" do
    assert Numbers.least_common_multiple_acc(8, 6) == 24
    assert Numbers.least_common_multiple_acc(6, 4) == 12
  end
end
