defmodule Ch277 do
  @moduledoc """
  Documentation for `Ch277`.
  """

  @doc """
  count search - it returns a map with items that are present "count" times
  """
  def count_search(w, count), do: w |> Enum.frequencies |> Map.filter(fn {_, val} -> val == count end)


  @doc """
  strong pair - it returns boolean whether the supplied array pair is a strong one or not
  """
  def strong_pair?([a,b]) when 0 < abs(a-b) and abs(a-b) < min(a,b), do: true
  def strong_pair?(_), do: false


end
