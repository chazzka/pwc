defmodule Task1 do
  def filter(enum), do: enum |> Enum.frequencies() |> Enum.filter(fn {k, v} -> k == v end)

  def justmax([]), do: -1
  def justmax(arr), do: arr |> Enum.max_by(fn {x, _} -> x end) |> then(fn {x, _} -> x end)
end

defmodule Task2 do
  def pruchod(zbytek, [], rovnaji), do: Enum.concat(rovnaji, zbytek |> Enum.sort())

  def pruchod(list1, [head | tail], rovnaji) do
    pruchod(
      list1 |> Enum.filter(&(&1 != head)),
      tail,
      rovnaji ++ (list1 |> Enum.filter(&(&1 == head)) |> Enum.sort())
    )
  end
end
