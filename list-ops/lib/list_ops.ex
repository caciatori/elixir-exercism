defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list()) :: integer()
  def count(l), do: do_count(l, 0)

  defp do_count([], acc), do: acc
  defp do_count([_h | t], acc), do: do_count(t, acc + 1)

  @spec reverse(list()) :: list()
  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([], acc), do: acc
  defp do_reverse([h | t], acc), do: do_reverse(t, [h] ++ acc)

  @spec map(list(), function()) :: list()
  def map(l, f), do: do_map(l, f, [])

  defp do_map([], _f, acc), do: acc
  defp do_map([h | t], f, acc), do: do_map(t, f, acc ++ [f.(h)])

  @spec filter(list(), function()) :: list()
  def filter(l, f), do: do_filter(l, f, [])

  defp do_filter([], _f, acc), do: acc

  defp do_filter([h | t], f, acc) do
    if f.(h) do
      do_filter(t, f, acc ++ [h])
    else
      do_filter(t, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, function()) :: acc
  def reduce(l, acc, f), do: do_reduce(l, acc, f)

  defp do_reduce([], acc, _f), do: acc
  defp do_reduce([h | t], acc, f), do: do_reduce(t, f.(h, acc), f)

  @spec append(list(), list()) :: list()
  def append(a, b), do: a ++ b

  @spec concat([[any]]) :: list()
  def concat(ll), do: do_concat(ll, [])

  defp do_concat([], acc), do: acc
  defp do_concat([h | t], acc), do: do_concat(t, append(acc, h))
end
