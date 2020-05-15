defmodule Bob do
  @whatever "Whatever."
  @chill_out "Whoa, chill out!"
  @sure "Sure."
  @calm_down "Calm down, I know what I'm doing!"
  @fine "Fine. Be that way!"

  def hey(""), do: @fine

  def hey(input) do
    cond do
      input =~ ~r/[[:upper:]!]+$/u -> @chill_out # -6
      input =~ ~r/[[:space:]]+$/ -> @fine # -4
      input =~ ~r/(\A[[:upper:]?'\s]+$)/ -> @calm_down # -2
      input =~ ~r/[?]+/ -> @sure # -2
      true -> @whatever
    end
  end

end
