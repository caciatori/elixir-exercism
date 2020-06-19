defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join()
    |> patch()
  end

  defp process("#" <> _rest = tag) do
    tag |> parse_header_md_level() |> enclose_with_header_tag()
  end

  defp process("*" <> _rest = tag) do
    parse_list_md_level(tag)
  end

  defp process(tag) do
    tag |> String.split() |> enclose_with_paragraph_tag
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {String.length(h), Enum.join(t, " ")}
  end

  defp parse_list_md_level("* " <> original_content) do
    tag_content =
      original_content
      |> String.split()
      |> join_words_with_tags()

    "<li>#{tag_content}</li>"
  end

  defp enclose_with_header_tag({hl, htl}), do: "<h#{hl}>#{htl}</h#{hl}>"

  defp enclose_with_paragraph_tag(t), do: "<p>#{join_words_with_tags(t)}</p>"

  defp join_words_with_tags(t) do
    t
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(w) do
    w
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  @strong_prefix_regex ~r/^#{"__"}{1}/
  @em_prefix_regex ~r/^[#{"_"}{1}][^#{"_"}+]/

  defp replace_prefix_md(w) do
    cond do
      w =~ @strong_prefix_regex ->
        String.replace(w, @strong_prefix_regex, "<strong>", global: false)

      w =~ @em_prefix_regex ->
        String.replace(w, ~r/_/, "<em>", global: false)

      true ->
        w
    end
  end

  @strong_suffix_regex ~r/#{"__"}{1}$/
  @em_suffix_regex ~r/[^#{"_"}{1}]/

  defp replace_suffix_md(w) do
    cond do
      w =~ @strong_suffix_regex ->
        String.replace(w, @strong_suffix_regex, "</strong>")

      w =~ @em_suffix_regex ->
        String.replace(w, ~r/_/, "</em>")

      true ->
        w
    end
  end

  defp patch(l) do
    l
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
