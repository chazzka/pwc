defmodule Task1 do
  def move_last_to_first([head | tail] = list) do
    case list do
      [_] ->
        list

      _ ->
        [last] = Enum.take(tail, -1)
        rest = Enum.drop(tail, -1)
        [last | [head | rest]]
    end
  end

  def index_to_put(numbers, number) do
    res = Enum.find_index(numbers, fn x -> x > number end)
    if res == nil, do: -1, else: res
  end

  def preprocess(arr), do: preprocess(arr, [], [])

  def preprocess([], strings, _) do
    strings |> Enum.map(&List.to_string/1) |> Enum.join(" ")
  end

  def preprocess([string | push], strings, numbers) do
    case {string, numbers} do
      # prazdne, proste to hod tam
      {[number | rest], []} ->
        preprocess(push, strings ++ [rest], numbers ++ [String.to_integer(number)])

      # uz tam neco je
      {[number | rest], [_ | _]} ->
        index = index_to_put(numbers, String.to_integer(number))

        preprocess(
          push,
          List.insert_at(strings, index, rest),
          List.insert_at(numbers, index, String.to_integer(number))
        )
    end
  end
end

defmodule Task2 do
  def split_while_inclusive(list, fun) do
    {first_part, rest} = Enum.split_while(list, fun)

    case rest do
      [] -> {first_part, []}
      [head | tail] -> {first_part ++ [head], tail}
    end
  end

  def preprocess(string, char) do
    {f, s} = string |> String.graphemes() |> split_while_inclusive(fn x -> x != char end)

    case s do
      [] -> string
      _ -> (f |> Enum.sort() |> Enum.join("")) <> (s |> Enum.join())
    end
  end
end

defmodule Task2Znovu do
  def to_hash([_, string, number]), do: {String.to_integer(number), string}

  def regex_to_hash(string) do
    Regex.run(~r/(\D+)(\d+)/, string) |> to_hash
  end
end
