defmodule Zipper do
  alias BinTree

  @type direction :: {:right_node, BinTree.t()} | {:left_node, BinTree.t()}
  @type t() :: {BinTree.t() | nil, list(direction)}

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(%BinTree{} = tree), do: {tree, []}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree({BinTree.t(), list()}) :: BinTree.t()
  def to_tree({%BinTree{} = tree, []}), do: tree

  def to_tree(zipper), do: zipper |> up() |> to_tree()

  @doc """
  Get the value of the focus node.
  """
  @spec value({%BinTree{}, list()}) :: any()
  def value({%BinTree{value: value}, _}), do: value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left({%BinTree{}, list()}) :: Zipper.t() | nil
  def left({%BinTree{left: nil}, _}), do: nil

  def left({%BinTree{left: left} = tree, nodes}) do
    {left, [{:left_node, tree} | nodes]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right({%BinTree{}, list()}) :: Zipper.t() | nil
  def right({%BinTree{right: nil}, _}), do: nil

  def right({%BinTree{right: right} = tree, nodes}) do
    {right, [{:right_node, tree} | nodes]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(any()) :: Zipper | nil
  def up({_, []}), do: nil

  def up({%BinTree{} = tree, [{:left_node, n_tree} | nodes]}) do
    {%{n_tree | left: tree}, nodes}
  end

  def up({%BinTree{} = tree, [{:right_node, n_tree} | nodes]}) do
    {%{n_tree | right: tree}, nodes}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value({BinTree.t(), list()}, any()) :: {BinTree.t(), list()}
  def set_value({%BinTree{} = tree, nodes}, value), do: {%{tree | value: value}, nodes}

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left({BinTree.t(), list()}, any()) :: {BinTree.t(), list()}
  def set_left({%BinTree{} = tree, nodes}, value), do: {%{tree | left: value}, nodes}

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right({BinTree.t(), list()}, any()) :: {BinTree.t(), list()}
  def set_right({%BinTree{} = tree, nodes}, value), do: {%{tree | right: value}, nodes}
end
