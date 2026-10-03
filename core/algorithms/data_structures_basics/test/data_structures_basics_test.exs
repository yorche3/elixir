defmodule DataStructuresBasicsTest do
  use ExUnit.Case
  doctest DataStructuresBasics

  test "greets the world" do
    assert DataStructuresBasics.hello() == :world
  end
end
