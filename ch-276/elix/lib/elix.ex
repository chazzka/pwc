defmodule Elix do
  @moduledoc """
  Documentation for `Elix`.
  """

  @doc """
  Checks if hours pair for a complete day (24+24+24...)
  """
  def complete_day?([a,b]), do: Integer.mod(a+b,24) == 0

  @doc """
  Counts number combinations of complete days in given enum
  """
  def complete_pairs(enum), do: enum |> Combination.combine(2) |> Stream.filter(&complete_day?/1) |> Enum.count

end
