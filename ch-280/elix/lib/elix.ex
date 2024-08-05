defmodule Task1 do
  def twice?(idk), do: twice?(idk, %{}, 0)
  def twice?(_, _, [key, 2]), do: key
  def twice?([char|tail], map, _) do
    merged = Map.merge(map, %{char => 1}, fn _key, val1, val2 -> val1+val2 end)
    twice?(tail, merged, [char, Map.get(merged, char)])
  end
end


defmodule Task2 do
  def every_other(enum) do
    enum
    |> Enum.with_index()
    |> Enum.filter(fn {_element, index} -> rem(index, 2) == 0 end)
    |> Enum.map(fn {element, _index} -> element end)
  end

  def count_stars(enum), do: Enum.count(enum, fn item -> item == "*" end)
end
