defmodule Ch277Test do
  use ExUnit.Case
  doctest Ch277

  test "count_search" do
    assert ["Perl", "is", "my", "friend"] |> Ch277.count_search(1) == %{"Perl" => 1, "friend" => 1, "is" => 1, "my" => 1}
  end

  test "ch1_1" do
    first = ["Perl", "is", "my", "friend"]
    |> Ch277.count_search(1)
    second = ["Perl", "and", "Raku", "are", "friend"]
    |> Ch277.count_search(1)

    assert Map.intersect(first, second) |> Map.values |> Enum.count == 2
  end

  test "ch1_2" do
    first = ["Perl", "and", "Python", "are", "very", "similar"]
    |> Ch277.count_search(1)
    second = ["Python", "is", "top", "in", "guest", "languages"]
    |> Ch277.count_search(1)

    assert Map.intersect(first, second) |> Map.values |> Enum.count == 1
  end

  test "ch1_3" do
    first = ["Perl", "is", "imperative", "Lisp", "is", "functional"]
    |> Ch277.count_search(1)
    second = ["Crystal", "is", "similar", "to", "Ruby"]
    |> Ch277.count_search(1)

    assert Map.intersect(first, second) |> Map.values |> Enum.count == 0
  end

  test "strong_pair" do
    assert Ch277.strong_pair?([2,3]) == true
    assert Ch277.strong_pair?([3,4]) == true
    assert Ch277.strong_pair?([3,5]) == true
    assert Ch277.strong_pair?([4,5]) == true
    assert Ch277.strong_pair?([5,5]) == false
  end

  test "ch2_1" do
    assert [1, 2, 3, 4, 5] |> Combination.combine(2) |> Enum.uniq |> Enum.filter(&(Ch277.strong_pair?(&1))) |> Enum.count == 4
  end

  test "ch2_2" do
    assert [5, 7, 1, 7] |> Combination.combine(2) |> Enum.uniq |> Enum.filter(&(Ch277.strong_pair?(&1))) |> Enum.count == 1
  end

end
