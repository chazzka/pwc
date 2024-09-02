defmodule ElixTest do
  use ExUnit.Case

  test "Task1" do
    [2, 2, 3, 4] |> Task1.filter() |> Task1.justmax() |> IO.inspect()
    [1, 2, 2, 3, 3, 3] |> Task1.filter() |> Task1.justmax() |> IO.inspect()
    [1, 1, 1, 3] |> Task1.filter() |> Task1.justmax() |> IO.inspect()
  end

  test "Task2" do
    Task2.pruchod([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6], []) |> IO.inspect()
    Task2.pruchod([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2], []) |> IO.inspect()
    Task2.pruchod([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2], []) |> IO.inspect()
  end
end
