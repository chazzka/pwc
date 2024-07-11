defmodule ElixTest do
  use ExUnit.Case
  doctest Elix

  test "greets the world" do
    assert Elix.hello() == :world
  end

  test "first" do
    assert "hjo" |> String.contains?("ab" |> String.graphemes) == false
    assert "hjob" |> String.contains?("ab" |> String.graphemes) == true

    assert "Perl Weekly Challenge" |> String.split(" ") |> Enum.filter(&!String.contains?(&1, "la" |> String.graphemes )) |> Enum.count == 0
    assert "Perl and Raku" |> String.split(" ") |> Enum.filter(&!String.contains?(&1, "a" |> String.graphemes )) |> Enum.count == 1
    assert "Well done Team PWC" |> String.split(" ") |> Enum.filter(&!String.contains?(&1, "lo" |> String.graphemes )) |> Enum.count == 2
    assert "The joys of polyglottism" |> String.downcase |> String.split(" ") |> Enum.filter(&!String.contains?(&1, "T" |> String.downcase |>String.graphemes )) |> Enum.count  == 2

  end
end
