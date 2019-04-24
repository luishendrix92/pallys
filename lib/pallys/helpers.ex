defmodule Pallys.Helpers do
  def count_by(list, mapper, sorter \\ &>=/2) do
    Enum.group_by(list, mapper)
    |> Enum.map(fn {k, l} -> {k, Enum.count(l)} end)
    |> Enum.sort_by(fn m -> elem(m, 1) end, sorter)
  end
end
