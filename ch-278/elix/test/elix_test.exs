defmodule ElixTest do
  use ExUnit.Case

  test "test_index_to_put" do
    assert [3] |> Task1.index_to_put(5) == -1
    assert [3] |> Task1.index_to_put(2) == 0
    assert [1,4,8,9] |> Task1.index_to_put(5) == 2
    assert [1,4,8,9] |> Task1.index_to_put(0) == 0
    assert [1,4,7,9] |> Task1.index_to_put(10) == -1
    assert [1,4,7,9] |> Task1.index_to_put(8) == 3
    # assert List.insert_at([1,2,3,4,8])
  end

  test "task1" do
    assert "and2 Raku3 cousins5 Perl1 are4" |> String.split(" ") |> Enum.map(&String.graphemes/1) |> Enum.map(&Task1.move_last_to_first/1) |> Task1.preprocess == "Perl and Raku are cousins"
    assert "guest6 Python1 most4 the3 popular5 is2 language7" |> String.split(" ") |> Enum.map(&String.graphemes/1) |> Enum.map(&Task1.move_last_to_first/1) |> Task1.preprocess  == "Python is the most popular guest language"
    assert "Challenge3 The1 Weekly2" |> String.split(" ") |> Enum.map(&String.graphemes/1) |> Enum.map(&Task1.move_last_to_first/1) |> Task1.preprocess == "The Weekly Challenge"
  end


  test "task2" do
    assert "challenge" |> Task2.preprocess("e") == "acehllnge"
    assert "programming" |> Task2.preprocess("a") == "agoprrmming"
    assert "champion" |> Task2.preprocess("b") == "champion"
  end

end
