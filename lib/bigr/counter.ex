defmodule Bigr.Counter do
  def new(count \\ 0), do: count
  def inc(count, by \\ 1), do: count + by

  def dec(count, by \\ 1) do
    if count == 0,
      do: count,
      else: count - by
  end

  def show(count \\ 0), do: Integer.to_string(count)
end
