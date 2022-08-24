defmodule MillarTest do
  use ExUnit.Case
  doctest Millar

  test "greets the world" do
    assert Millar.hello() == :world
  end
end
