defmodule ElixTest do
  use ExUnit.Case
  doctest Elix

  test "greets the world" do
    assert Elix.hello() == :world
  end

  test "task1" do
    assert Enum.zip([3, 2, 1, 4],["R", "E", "P", "L"])
    |> Enum.sort
    |> Stream.map(fn {_, char} -> char end)
    |> Enum.join() == "PERL"

    assert Enum.zip([2, 4, 1, 3], ["A", "U", "R", "K"])
    |> Enum.sort
    |> Stream.map(fn {_, char} -> char end)
    |> Enum.join() == "RAKU"

    assert Enum.zip([5, 4, 2, 6, 1, 3], ["O", "H", "Y", "N", "P", "T"])
    |> Enum.sort
    |> Stream.map(fn {_, char} -> char end)
    |> Enum.join() == "PYTHON"
  end



  def count_vowels(something), do: count_vowels(something, ~w(a e i o u A E I O U), 0)
  def count_vowels([char|rest], vowels, count), do: count_vowels(rest, vowels, count + (if char in vowels, do: 1, else: 0))
  def count_vowels([], _, count), do: count

  test "count_vowels" do
    assert "AHOJ" |> String.graphemes |> count_vowels == 2
    assert "NAZDAR AHOJ" |> String.graphemes |> count_vowels == 4
  end

  test "task2" do
    assert "perl" |> String.graphemes |> then(fn x -> rem(count_vowels(x),2) == 0 end) == false
    assert "book" |> String.graphemes |> then(fn x -> rem(count_vowels(x),2) == 0 end) == true
    assert "good morning" |> String.graphemes |> then(fn x -> rem(count_vowels(x),2) == 0 end) == true
  end
end
