defmodule NumbersRecTest do
  use ExUnit.Case
  doctest Numbers

  test "Sum of first n numbers Recursive" do
    assert Numbers.sum_first_n_rec(0) == 0
    assert Numbers.sum_first_n_rec(3) == 6
  end

  test "Factorial Recursive" do
    assert Numbers.factorial_rec(0) == 1
    assert Numbers.factorial_rec(4) == 24
  end

  test "Fibonacci Recursive" do
    assert Numbers.fibonacci_rec(0) == 0
    assert Numbers.fibonacci_rec(1) == 1
    assert Numbers.fibonacci_rec(6) == 8
  end

  test "Greatest Common Divisor Recursive" do
    assert Numbers.greatest_common_divisor_rec(12, 8) == 4
    assert Numbers.greatest_common_divisor_rec(7, 5) == 1
  end

  test "Least Common Multiple Recursive" do
    assert Numbers.least_common_multiple_rec(8, 6) == 24
    assert Numbers.least_common_multiple_rec(6, 4) == 12
  end
end
