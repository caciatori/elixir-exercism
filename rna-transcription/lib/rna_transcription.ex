defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    transcriptor(dna, '')
  end

  @rna_map %{
    'C' => 'G',
    'G' => 'C',
    'T' => 'A',
    'A' => 'U'
  }

  defp transcriptor(char, acc) when length(char) > 0 do
    [h | t] = char
    transcriptor(t, acc ++ @rna_map[[h]])
  end

  defp transcriptor(_char, acc)do
    acc
  end
end
