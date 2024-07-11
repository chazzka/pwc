defmodule ElixTest do
  use ExUnit.Case
  doctest Elix


  test "complete day" do
    assert Elix.complete_day?([12,12]) == true
    assert Elix.complete_day?([24,24]) == true
    assert Elix.complete_day?([72,48]) == true
    assert Elix.complete_day?([12,13]) == false
  end

  test "complete_pairs" do
    assert Elix.complete_pairs([12, 12, 30, 24, 24]) == 2
    assert Elix.complete_pairs([72, 48, 24, 5]) == 3
    assert Elix.complete_pairs([12, 18, 24]) == 0
  end

end
