defmodule Task1 do
  def three?(string), do: three?(string, [], 0, "X")

  def three?([char | rest], result, counter, last) when last == char,
    do: three?(rest, result ++ [char], counter + 1, char)

  def three?(_, result, counter, last) when counter == 2, do: (result ++ [last]) |> Enum.join()
  def three?([char | rest], _, _, _), do: three?(rest, [], 0, char)
  def three?([], _, _, _), do: -1
end

defmodule Task2 do
  def keychanges([char | rest]), do: keychanges(rest, char, 0)

  def keychanges([char | rest], last_char, changes) when char == last_char,
    do: keychanges(rest, char, changes)

  def keychanges([char | rest], _, changes), do: keychanges(rest, char, changes + 1)
  def keychanges([], _, changes), do: changes
end
