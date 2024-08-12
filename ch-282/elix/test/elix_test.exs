defmodule ElixTest do
  use ExUnit.Case


  test "threedigits" do
    assert 12_344_456 |> Integer.to_string() |> String.graphemes() |> Task1.three? == "444"
    assert 1_233_334 |> Integer.to_string() |> String.graphemes() |> Task1.three? == -1
    assert 10_020_003 |> Integer.to_string() |> String.graphemes() |> Task1.three? == "000"
  end

  test "keychanges" do
    assert "pPeERrLl" |> String.downcase() |> String.graphemes() |> Task2.keychanges == 3
    assert "rRr" |> String.downcase() |> String.graphemes() |> Task2.keychanges == 0
    assert "GoO" |> String.downcase() |> String.graphemes() |> Task2.keychanges == 1
  end
end
