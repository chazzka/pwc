defmodule ElixTest do
  use ExUnit.Case


  test "task1" do
    assert "acbddbca" |> String.graphemes |> Task1.twice? == "d"
    assert "abccd" |> String.graphemes |> Task1.twice? == "c"
    assert "abcdabbb" |> String.graphemes |> Task1.twice? == "a"
  end


  test "task2" do
    assert "p|*e*rl|w**e|*ekly|" |> String.split("|") |> Task2.every_other |> Enum.join |> String.graphemes |> Task2.count_stars == 2
    assert "perl" |> String.split("|") |> Task2.every_other |> Enum.join |> String.graphemes |> Task2.count_stars == 0
    assert "th|ewe|e**|k|l***ych|alleng|e" |> String.split("|") |> Task2.every_other |> Enum.join |> String.graphemes |> Task2.count_stars == 5
  end

end
