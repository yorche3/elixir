defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator

  test "Addition Test" do
    assert Calculator.addition(3, 2) == 5
  end

  test "Subtraction Test" do
    assert Calculator.subtraction(5, 2) == 3
  end

  test "Multiplication Test" do
    assert Calculator.multiplication(4, 3) == 12
  end

  test "Division Test" do
    assert Calculator.division(10, 3) == 3
  end

  test "Modulus Test" do
    assert Calculator.modulus(10, 3) == 1
  end
end
