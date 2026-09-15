defmodule Numbers do
  @moduledoc """
  Documentation for `Numbers`.
  """

  def sum_first_n_rec(n) when n <= 0, do: 0
  def sum_first_n_rec(n), do: n + sum_first_n_rec(n - 1)

  def factorial_rec(n) when n <= 0, do: 1
  def factorial_rec(n), do: n * factorial_rec(n - 1)

  def fibonacci_rec(n) when n <= 0, do: 0
  def fibonacci_rec(1), do: 1
  def fibonacci_rec(n), do: fibonacci_rec(n - 1) + fibonacci_rec(n - 2)

  def greatest_common_divisor_rec(a, 0), do: a
  def greatest_common_divisor_rec(a, b), do: greatest_common_divisor_rec(b, rem(a, b))

  def least_common_multiple_rec(a, b) do
    quotient = greatest_common_divisor_rec(a, b)
    a * b |> div(quotient)
  end

  def sum_first_n_acc(n), do: _sum_first_n_help(n, 0)
  def _sum_first_n_help(n, acc) when n <= 0, do: acc
  def _sum_first_n_help(n, acc), do: _sum_first_n_help(n - 1, acc + n)

  def factorial_acc(n), do: _factorial_help(n, 1)
  def _factorial_help(n, acc) when n <= 0, do: acc
  def _factorial_help(n, acc), do: _factorial_help(n - 1, acc * n)

  def fibonacci_acc(n), do: _fibonacci_help(n, 0, 1)
  def _fibonacci_help(n, acc1, _) when n <= 0, do: acc1
  def _fibonacci_help(n, acc1, acc2), do: _fibonacci_help(n - 1, acc2, acc1 + acc2)

  def greatest_common_divisor_acc(a, 0), do: a
  def greatest_common_divisor_acc(a, b), do: greatest_common_divisor_acc(b, rem(a, b))

  def least_common_multiple_acc(a, b) do
    quotient = greatest_common_divisor_acc(a, b)
    a * b |> div(quotient)
  end
end
