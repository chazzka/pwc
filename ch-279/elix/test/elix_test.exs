defmodule ElixTest do
  use ExUnit.Case
  doctest Elix

  test "greets the world" do
    assert Elix.hello() == :world
  end

  test "task1" do
    assert Enum.zip(["R", "E", "P", "L"], [3, 2, 1, 4])
    |> Enum.sort(fn {_k1, v1}, {_k2, v2} -> v1 <= v2 end)
    |> Stream.map(fn {char, _} -> char end)
    |> Enum.join() == "PERL"

    assert Enum.zip(["A", "U", "R", "K"], [2, 4, 1, 3])
    |> Enum.sort(fn {_k1, v1}, {_k2, v2} -> v1 <= v2 end)
    |> Stream.map(fn {char, _} -> char end)
    |> Enum.join() == "RAKU"

    assert Enum.zip(["O", "H", "Y", "N", "P", "T"], [5, 4, 2, 6, 1, 3])
    |> Enum.sort(fn {_k1, v1}, {_k2, v2} -> v1 <= v2 end)
    |> Stream.map(fn {char, _} -> char end)
    |> Enum.join() == "PYTHON"
  end



  def count_vowels(something), do: count_vowels(something, ~w(a e i o u A E I O U), 0)
  def count_vowels([char|rest], vowels, count), do: count_vowels(rest, vowels, count + (if char in vowels, do: 1, else: 0))
  # def count_vowels([char|rest], vowels, count), do: count_vowels(rest, vowels, count)
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
