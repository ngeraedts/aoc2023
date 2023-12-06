import AOC

aoc 2023, 1 do
  @moduledoc """
  https://adventofcode.com/2023/day/1
  """

  @doc """
      iex> p1(example_input())
  """
  def p1(input) do
    input
    |> String.split()
    |> Enum.map(fn line ->
      digits =
        line
        |> String.codepoints()
        |> Enum.map(&safe_int(&1))
        |> Enum.reject(&is_nil/1)

      [List.first(digits), List.last(digits)]
      |> Enum.join()
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  defp safe_int(cp) do
    String.to_integer(cp)
  rescue
    _ ->
      nil
  end

  @doc """
      iex> p2(example_input())
  """
  def p2(input) do
    input
    |> String.split()
    |> Enum.map(fn line ->
      digits =
        line
        |> String.codepoints()
        |> Enum.map(&safe_int(&1))
        |> Enum.reject(&is_nil/1)

      [List.first(digits), List.last(digits)]
      |> Enum.join()
      |> String.to_integer()
    end)
    |> Enum.sum()
  end
end
