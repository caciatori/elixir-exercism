defmodule RomanNumerals do
  @romans [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    transform(number, @romans, "")
  end

  defp transform(_value, [], acc), do: acc

  defp transform(value, roman_symbols, acc) do
    [current | rest] = roman_symbols

    {number, symbol} = current

    result = div(value, number)

    if result > 0 do
      acc = acc <> String.duplicate(symbol, result)
      transform(value - number * result, rest, acc)
    else
      transform(value, rest, acc)
    end
  end
end
