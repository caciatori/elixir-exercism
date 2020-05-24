defmodule BeerSong do
  @verse_number_zero "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
  @verse_number_one "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"

  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number)
  def verse(0), do: @verse_number_zero
  def verse(1), do: @verse_number_one
  def verse(number), do: build_verse(number)

  defp build_verse(number) do
    next_number = number - 1

    word_bottle =
      if next_number == 1 do
        "bottle"
      else
        "bottles"
      end

    "#{number} bottles of beer on the wall, #{number} bottles of beer.\nTake one down and pass it around, #{
      next_number
    } #{word_bottle} of beer on the wall.\n"
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0)
  def lyrics(range), do: range |> Enum.to_list() |> build_lyrics("")

  defp build_lyrics([], acc), do: acc
  defp build_lyrics([h | []], acc), do: acc <> verse(h)
  defp build_lyrics([h | t], acc), do: build_lyrics(t, acc <> verse(h) <> "\n")
end
