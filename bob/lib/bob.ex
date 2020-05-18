defmodule Bob do
  def hey(input) do
    calm_down = "Calm down, I know what I'm doing!"
    chill_out = "Whoa, chill out!"
    fine = "Fine. Be that way!"
    sure = "Sure."
    whatever = "Whatever."

    input = String.trim(input)
    cond do
      input =~ ~r/(^[A-Z]+\W)/ and input =~ ~r/\?$/ -> calm_down
      input == "" or input =~ ~r/(^[[:space:]])/ -> fine
      input =~ ~r/\?$/ -> sure
      input =~ ~r/([[:upper:]]+$)/u or input =~ ~r/(([A-Z0-9]+!$))/ -> chill_out
      true -> whatever
    end
  end
end
