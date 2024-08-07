defmodule Task1 do
  def light?(coordinates) do
    {letter, number} =
      coordinates
      |> String.graphemes()
      |> Enum.map(&String.to_charlist/1)
      |> then(fn [[let | _], [let2 | _]] -> {let, let2} end)

    checker = if rem(letter, 2) == 1, do: 0, else: 1
    rem(number, 2) == checker
  end
end

defmodule Tree do
  defstruct key: nil, value: nil, children: %{}

  # Function to find a node with a specific key
  def find_node(nil, _key), do: nil
  def find_node(%Tree{key: key} = node, key), do: node

  def find_node(%Tree{children: children}, key) do
    children
    |> Map.values()
    |> Enum.find_value(nil, fn child -> find_node(child, key) end)
  end

  # Function to insert a node into the tree
  def insert_node(nil, key, depth), do: %Tree{key: key, value: depth}

  def insert_node(%Tree{} = tree, key, depth) do
    if has_key?(tree, key) do
      tree
    else
      insert_node_recursive(tree, key, depth)
    end
  end

  defp insert_node_recursive(%Tree{} = tree, key, depth) do
    %Tree{tree | children: Map.put(tree.children, key, %Tree{key: key, value: depth})}
  end

  # Function to check if a specific key exists in the tree
  def has_key?(nil, _key), do: false
  def has_key?(%Tree{key: key}, key), do: true

  def has_key?(%Tree{children: children}, key) do
    children
    |> Map.values()
    |> Enum.any?(fn child -> has_key?(child, key) end)
  end

  @doc """
    does not save already existing
  """
  def insert_nodes_under(nil, _parent_key, _children), do: nil

  def insert_nodes_under(%Tree{} = tree, parent_key, children) do
    if parent_key == tree.key do
      Enum.reduce(children, tree, fn key, acc ->
        if has_key?(acc, key) do
          acc
        else
          insert_node_recursive(acc, key, tree.value + 1)
        end
      end)
    else
      updated_children =
        Map.new(tree.children, fn {child_key, child_tree} ->
          {child_key, insert_nodes_under(child_tree, parent_key, children)}
        end)

      %Tree{tree | children: updated_children}
    end
  end

  def get_children_keys(nil, _key), do: []

  def get_children_keys(%Tree{} = tree, key) do
    case find_node(tree, key) do
      nil -> []
      %Tree{children: children} -> Map.keys(children)
    end
  end

  def get_keys_at_depth(tree, depth) do
    get_keys_at_depth(tree, depth, [])
  end

  defp get_keys_at_depth(nil, _depth, acc), do: acc

  defp get_keys_at_depth(%Tree{key: key, value: value, children: children} = _tree, depth, acc) do
    acc = if value == depth, do: [key | acc], else: acc

    children
    |> Map.values()
    |> Enum.reduce(acc, fn child, acc -> get_keys_at_depth(child, depth, acc) end)
  end

  @doc """
   na konci teto funkce by mel byt strom, do ktereho se insertnuly vechny jumps ke klicum ktere prisly v druhem argumentu
  """
  def multi_insert(tree, [], _), do: tree

  def multi_insert(tree, [key | rest], jumps_function) do
    multi_insert(insert_nodes_under(tree, key, jumps_function.(key)), rest, jumps_function)
  end

  def insert_recursively(endP, tree, jumps_function, current_level) do
    # nejrpve ziskej vsechny klice na aktualnim levelu
    current_keys = get_keys_at_depth(tree, current_level)
    # insert pro vsecky zvlast:
    new_tree = multi_insert(tree, current_keys, jumps_function)
    # kontrola jestli tam neni nas:
    if has_key?(new_tree, endP) do
      # pokud je tak ho vrat
      find_node(new_tree, endP).value
    else
      insert_recursively(endP, new_tree, jumps_function, current_level + 1)
    end
  end
end

defmodule Task2 do

  def numeric_value(coordinates) do
    [letter, number] = coordinates |> String.graphemes()
    [numeric | _] = letter |> String.to_charlist()
    {numeric, number |> String.to_integer()}
  end

  def string_value(numeric_tuple) do
    {ascii, number} = numeric_tuple
    to_string(<<ascii>>) <> to_string(number)
  end

  def is_in_board?({x, y}), do: x >= 97 && x <= 104 && y >= 1 && y <= 8

  @doc """
  prints all the jump options from init position
  """
  def jump_options(init) do
    {x, y} = numeric_value(init)

    res = [
      {x + 2, y + 1},
      {x + 2, y - 1},
      {x + 1, y + 2},
      {x + 1, y - 2},
      {x - 1, y - 2},
      {x - 2, y - 1},
      {x - 2, y + 1},
      {x - 1, y + 2}
    ]

    # filter out non available options
    res |> Enum.filter(&is_in_board?/1) |> Enum.map(&string_value/1)
  end

  def knights_move(startP, endP) do
    # we start with empty tree
    root = %Tree{key: startP, value: 0}
    # you insert first children under root
    new_tree = Tree.insert_nodes_under(root, root.key, jump_options(root.key))
    # now the recursion can start
    Tree.insert_recursively(endP, new_tree, &jump_options/1, 1)
  end
end
