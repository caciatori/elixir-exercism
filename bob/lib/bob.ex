defmodule Bob do
  def hey(input) do
    calm_down = "Calm down, I know what I'm doing!"
    chill_out = "Whoa, chill out!"
    fine = "Fine. Be that way!"
    sure = "Sure."
    whatever = "Whatever."

    input = String.trim(input)

    cond do
      calm_down?(input) ->
        calm_down

      empty?(input) ->
        fine

      question?(input) ->
        sure

      chill_out?(input) ->
        chill_out

      true ->
        whatever
    end
  end

  defp empty?(input), do: "" == input

  defp question?(input), do: String.ends_with?(input, "?")

  defp all_upcase?(input), do: String.upcase(input) == input and String.downcase(input) != input

  defp calm_down?(input), do: all_upcase?(input) and String.ends_with?(input, "?")

  defp chill_out?(input) do
    (all_upcase?(input) and String.ends_with?(input, "!")) or all_upcase?(input)
  end
end
