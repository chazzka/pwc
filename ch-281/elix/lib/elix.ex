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
