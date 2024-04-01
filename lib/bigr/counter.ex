defmodule Bigr.Counter do
  def new(count \\ 0), do: count
  def inc(count, by \\ 1), do: count + by
  def show(count), do: Integer.to_string(count)
end
