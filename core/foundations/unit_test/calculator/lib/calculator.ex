defmodule Calculator do
  @moduledoc """
  Documentation for `Calculator`.
  """

  def addition(a, b), do: a + b

  def subtraction(a, b), do: a - b

  def multiplication(a, b) do
    _multiplication_loop(a, b, a)
  end

  def _multiplication_loop(_, b, product) when b == 1, do: product
  def _multiplication_loop(a, b, product) do
    _multiplication_loop(a, subtraction(b, 1), addition(product, a))
  end

  def division(a, b) do
    _division_loop(a, b, 0)
  end

  def _division_loop(a, b, quotient) when a < b or b == 0, do: quotient
  def _division_loop(a, b, quotient) do
    _division_loop(subtraction(a, b), b, addition(quotient, 1))
  end

  def modulus(a, b) do
    quotient = division(a, b)
    subtraction(a, multiplication(b, quotient))
  end
end
