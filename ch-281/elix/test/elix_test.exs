defmodule ElixTest do
  use ExUnit.Case

  test "light" do
    assert Task1.light?("a1") == false
    assert Task1.light?("b1") == true
    assert Task1.light?("a2") == true
    assert Task1.light?("b2") == false

    assert Task1.light?("d3") == true
    assert Task1.light?("g5") == false
    assert Task1.light?("e6") == true
  end


  def numeric_value(coordinates) do
    [letter, number] = coordinates |> String.graphemes
    [numeric | _] = letter |> String.to_charlist
    {numeric, number |> String.to_integer}
  end

  def string_value(numeric_tuple) do
    {ascii, number}= numeric_tuple
    to_string(<<ascii>>) <> to_string(number)
  end

  test "numeric value" do
    assert "g2" |> numeric_value == {103,2}
    assert "a8" |> numeric_value == {97,8}
  end

  @doc"""
  get score between two coordinates
  - check x coordinate vs target x
  - check y coordinate vs target y
  - overal score is the sum - you have to get closer on both x and y
  """
  def score(c_string,target_string) do
    {c, target} = {c_string |> numeric_value, target_string |> numeric_value}
    {cx, cy} = c
    {tx, ty} = target
    abs(tx-cx) + abs(ty-cy)
  end

  test "score" do
    assert ("f4" |> score("a8")) == ("e3" |> score("a8"))
  end

  @doc"""
  prints all the jump options from init position
  """
  def jump_options(init) do
    {x,y} = numeric_value(init)
    res = [{x+2,y+1}, {x+2,y-1},{x+1,y+2},{x+1,y-2},  {x-1,y-2}, {x-2,y-1}, {x-2,y+1}, {x-1,y+2}]
    res |> Enum.map(&string_value/1)
  end

  test "jump_options" do
    assert "d5" |> jump_options == ["f6", "f4", "e7", "e3", "c3", "b4", "b6", "c7"]
  end

  """
  if you have higher border score, you are closer to center
  """
  def border_score(policko) do
    {x,y} = policko |> numeric_value
    x_min = 97
    x_max = 104
    y_min = 1
    y_max = 8

    distance_to_x_border = min(x - x_min, x_max - x)
    distance_to_y_border = min(y - y_min, y_max - y)

    distance_to_x_border + distance_to_y_border
  end

  test "border_score" do
    assert border_score("a1") == border_score("h1")
    assert border_score("d5") > border_score("b1")
    # assert border_score("b6") > border_score("a5")
  end

  def get_best_option(options, goal) do
    zipped = options |> Enum.map(&score(&1 ,goal)) |> Enum.zip(options)
    {min_score, _} = zipped |> Enum.min_by(fn {score, _pos} -> score end)
    filtered = Enum.filter(zipped, fn {score, _pos} -> score == min_score end)
    # closer_to_center = Enum.min_by(filtered, fn {_, pos} -> border_score(pos) end)

  end

  test "best options" do
    # get_best_option(jump_options("g2"), "a8") |> IO.inspect
    # get_best_option(jump_options("d5"), "a8") |> IO.inspect
    get_best_option(jump_options("c4"), "a8") |> IO.inspect
  end

  # def find_goal(initial_position, goal) do
  #   Stream.iterate(initial_position, fn current_position ->
  #     options = jump_options(current_position)
  #     get_best_option(options, goal)
  #   end)
  #   |> Enum.take_while(fn position -> Enum.member?(jump_options(position),goal) end)
  #   # |> Enum.take_while(fn position -> position |> IO.inspect > 5 end)
  # end


  # test "find_goal" do
  #   # find_goal("g2", "a8") |> IO.inspect
  #   find_goal("e3", "b6") |> IO.inspect
  # end




end
