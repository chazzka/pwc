defmodule ElixTest do
  use ExUnit.Case
  doctest Elix

  test "exactly_one" do
    {val, _} = [3, 3, 1] |> Enum.frequencies() |> Enum.find(fn {_, v} -> v == 1 end)
    assert val == 1

    {val, _} = [3, 2, 4, 2, 4] |> Enum.frequencies() |> Enum.find(fn {_, v} -> v == 1 end)
    assert val == 3

    {val, _} = [1] |> Enum.frequencies() |> Enum.find(fn {_, v} -> v == 1 end)
    assert val == 1

    {val, _} = [4, 3, 1, 1, 1, 4] |> Enum.frequencies() |> Enum.find(fn {_, v} -> v == 1 end)
    assert val == 3
  end

  def how_many(list, digit) do
    res = list |> Enum.frequencies() |> Enum.find(fn {k, _} -> k == digit end)

    case res do
      nil -> 0
      {_, val} -> val
    end
  end

  def digit_count(input),
    do: digit_count(input, Enum.zip(0..(length(input) - 1), input))

  def digit_count(input, [{digit, times} | zip_rest]),
    do: if(!(how_many(input, digit) == times), do: false, else: digit_count(input, zip_rest))

  def digit_count(_, []), do: true

  test "digit_count" do
    assert how_many([1, 2, 1, 0], 1) == 2
    assert how_many([1, 2, 1, 0], 2) == 1
    assert how_many([1, 2, 1, 0], 3) == 0
    assert digit_count([1, 2, 1, 0]) == true
    assert digit_count([0, 3, 0]) == false
  end

  def frequencies_comp(input) do
    first = Enum.zip(0..(length(input) - 1), input) |> Enum.filter(fn {_, v} -> v != 0 end)
    second = input |> Enum.frequencies() |> Enum.to_list()
    first == second
  end

  test "pokus 2" do
    assert frequencies_comp([1, 2, 1, 0]) == true
    assert frequencies_comp([0, 3, 0]) == false
  end
end
