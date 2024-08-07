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

  test "numeric value" do
    assert "g2" |> Task2.numeric_value == {103, 2}
    assert "a8" |> Task2.numeric_value == {97, 8}
  end

  test "jump_options" do
    assert "d5" |> Task2.jump_options == ["f6", "f4", "e7", "e3", "c3", "b4", "b6", "c7"]
    assert "h1" |> Task2.jump_options == ["f2", "g3"]
  end

  test "tree" do
    root = %Tree{key: "root", value: 0}
    root2 = Tree.insert_nodes_under(root, "root", ["a1", "b2"])
    root3 = Tree.insert_nodes_under(root2, "a1", ["c5"])

    assert root3 == %Tree{
             key: "root",
             value: 0,
             children: %{
               "a1" => %Tree{
                 key: "a1",
                 value: 1,
                 children: %{"c5" => %Tree{key: "c5", value: 2, children: %{}}}
               },
               "b2" => %Tree{key: "b2", value: 1, children: %{}}
             }
           }

    assert Tree.has_key?(root3, "a1") == true
    assert Tree.has_key?(root3, "c5") == true
    assert Tree.get_children_keys(root3, "a1") == ["c5"]
    assert Tree.get_children_keys(root3, "root") == ["a1", "b2"]
    assert Tree.get_keys_at_depth(root3, 2) == ["c5"]
    assert Tree.get_keys_at_depth(root3, 1) == ["b2", "a1"]
  end

  test "multi insert" do
    root = %Tree{key: "g2", value: 0}
    next = Tree.multi_insert(root, ["g2"], &Task2.jump_options/1)
    # nejprve insert k jednomu klici v rootu
    assert next == %Tree{
             key: "g2",
             value: 0,
             children: %{
               "e1" => %Tree{key: "e1", value: 1, children: %{}},
               "e3" => %Tree{key: "e3", value: 1, children: %{}},
               "f4" => %Tree{key: "f4", value: 1, children: %{}},
               "h4" => %Tree{key: "h4", value: 1, children: %{}}
             }
           }

    # ted insert k nejakemu diteti, pod e1 a e3 by mely byt nove options
    next2 = Tree.multi_insert(next, ["e1", "e3"], &Task2.jump_options/1)

    assert next2 == %Tree{
             key: "g2",
             value: 0,
             children: %{
               "e1" => %Tree{
                 key: "e1",
                 value: 1,
                 children: %{
                   "c2" => %Tree{key: "c2", value: 2, children: %{}},
                   "d3" => %Tree{key: "d3", value: 2, children: %{}},
                   "f3" => %Tree{key: "f3", value: 2, children: %{}},
                   "g2" => %Tree{key: "g2", value: 2, children: %{}}
                 }
               },
               "e3" => %Tree{
                 children: %{
                   "c2" => %Tree{key: "c2", value: 2, children: %{}},
                   "c4" => %Tree{key: "c4", value: 2, children: %{}},
                   "d1" => %Tree{key: "d1", value: 2, children: %{}},
                   "d5" => %Tree{key: "d5", value: 2, children: %{}},
                   "f1" => %Tree{key: "f1", value: 2, children: %{}},
                   "f5" => %Tree{key: "f5", value: 2, children: %{}},
                   "g2" => %Tree{key: "g2", value: 2, children: %{}},
                   "g4" => %Tree{key: "g4", value: 2, children: %{}}
                 },
                 key: "e3",
                 value: 1
               },
               "f4" => %Tree{key: "f4", value: 1, children: %{}},
               "h4" => %Tree{key: "h4", value: 1, children: %{}}
             }
           }
  end

  test "Task 2" do
    assert Task2.knights_move("g2", "a8") == 4
    assert Task2.knights_move("g2", "h2") == 3
  end
end
