defmodule MaybeTest do
  use ExUnit.Case, parallel: true

  require Maybe

  def test_map,    do: %{foo: 9, bar: 153}
  def return_nil,  do: test_map[:quux]
  def return_some, do: test_map[:foo]

  test "apply returns nil for nil" do
    assert nil = Maybe.apply(return_nil)
  end

  test "apply returns some for non-nil" do
    assert {:ok, 9} = Maybe.apply(return_some)
  end

  test "get_or_else returns the element for some" do
    assert 9 = Maybe.apply(return_some) |> Maybe.get_or_else(0)
  end

  test "get_or_else returns the default for nil" do
    assert 0 = Maybe.apply(return_nil)|> Maybe.get_or_else(0)
  end

  test "it composes" do
    assert 153 =
      test_map
      |> Map.get(:bar)
      |> Maybe.apply
      |> Maybe.get_or_else(88)

    assert 88 =
      test_map
      |> Map.get(:baz)
      |> Maybe.apply
      |> Maybe.get_or_else(88)
  end
end
