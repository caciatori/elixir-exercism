defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r{[.!?:&@$%^,\\]}, "")
    |> String.replace("  ", " ")
    |> String.split(~r{[^A-Za-z0-9äöüÄÖÜß-]})
    |> Enum.reduce(%{}, fn word, acc ->
      word = String.downcase(word)
      case Map.get(acc, word) do
        nil -> Map.put(acc, word, 1)
        count -> Map.put(acc, word, count + 1)
      end
    end)
  end
end
