defmodule TryTest do
  use ExUnit.Case, parallel: true

  require Try

  test "apply/1 returns the result for a success" do
    assert 4 = Try.apply(2 + 2)
  end

  test "apply/1 returns a failure for a dangerous computation" do
    assert {:failure, reason} = Try.apply(2 / 0)
  end

  test "apply/2 returns a result for a success" do
    assert 7 = Try.apply(fn(x, y) -> x + y + 2 end, [2,3])
  end

  test "apply/2 returns a failure for a dangerous computation" do
    assert {:failure, reason} = Try.apply(fn(x, y) -> x * y / 0 end, [2,3])
  end
end
