defmodule RomanNumerals do
  @romans %{
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1000 => "M"
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    convert_to_roman(number, "")
  end

  def convert_to_roman(0, acc) do
    acc
  end

  def convert_to_roman(number, acc) when div(number, 1000) > 0 do
    acc = acc <> @romans[1000]

    convert_to_roman(number - 1000, acc)
  end

  def convert_to_roman(number, acc) when div(number, 900) > 0 do
    acc = acc <> duplicate(@romans[900], div(number, 900))

    convert_to_roman(number - 900, acc)
  end

  def convert_to_roman(number, acc) when div(number, 500) > 0 do
    acc = acc <> duplicate(@romans[500], div(number, 500))

    convert_to_roman(number - 500, acc)
  end

  def convert_to_roman(number, acc) when div(number, 400) > 0 do
    acc = acc <> duplicate(@romans[400], div(number, 400))

    convert_to_roman(number - 400, acc)
  end

  def convert_to_roman(number, acc) when div(number, 100) > 0 do
    acc = acc <> duplicate(@romans[100], div(number, 100))

    convert_to_roman(number - 100, acc)
  end

  def convert_to_roman(number, acc) when div(number, 90) > 0 do
    acc = acc <> duplicate(@romans[90], div(number, 90))

    convert_to_roman(number - 90, acc)
  end

  def convert_to_roman(number, acc) when div(number, 50) > 0 do
    acc = acc <> duplicate(@romans[50], div(number, 50))

    convert_to_roman(number - 50, acc)
  end

  def convert_to_roman(number, acc) when div(number, 40) > 0 do
    acc = acc <> duplicate(@romans[40], div(number, 40))

    convert_to_roman(number - 40, acc)
  end

  def convert_to_roman(number, acc) when div(number, 10) > 0 do
    result = div(number, 10)

    acc = acc <> duplicate(@romans[10], result)

    convert_to_roman(number - (10 * result) , acc)
  end

  def convert_to_roman(number, acc) when div(number, 9) > 0 do
    acc = acc <> duplicate(@romans[9], div(number, 9))

    convert_to_roman(number - 9, acc)
  end

  def convert_to_roman(number, acc) when div(number, 5) > 0 do
    acc = acc <> duplicate(@romans[5], div(number, 5))

    convert_to_roman(number - 5, acc)
  end

  def convert_to_roman(number, acc) when div(number, 4) > 0 do
    acc <> duplicate(@romans[4], div(number, 4))
  end

  def convert_to_roman(number, acc) when div(number, 1) > 0 do
    acc <> duplicate(@romans[1], div(number, 1))
  end

  def duplicate(char, times) do
    String.duplicate(char, times)
  end
end
