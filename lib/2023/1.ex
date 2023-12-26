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
        |> iterate_digits()

      [List.first(digits), List.last(digits)]
      |> Enum.join()
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  # def parse_with_numbers()

  def iterate_digits(input, digits \\ [])

  def iterate_digits("", digits), do: :lists.reverse(digits)

  # This apparently never shows up in the input.
  # defp iterate_digits("0" <> rest, digits), do: iterate_digits(rest, [0 | digits])

  def iterate_digits("1" <> rest, digits), do: iterate_digits(rest, [1 | digits])
  def iterate_digits("2" <> rest, digits), do: iterate_digits(rest, [2 | digits])
  def iterate_digits("3" <> rest, digits), do: iterate_digits(rest, [3 | digits])
  def iterate_digits("4" <> rest, digits), do: iterate_digits(rest, [4 | digits])
  def iterate_digits("5" <> rest, digits), do: iterate_digits(rest, [5 | digits])
  def iterate_digits("6" <> rest, digits), do: iterate_digits(rest, [6 | digits])
  def iterate_digits("7" <> rest, digits), do: iterate_digits(rest, [7 | digits])
  def iterate_digits("8" <> rest, digits), do: iterate_digits(rest, [8 | digits])
  def iterate_digits("9" <> rest, digits), do: iterate_digits(rest, [9 | digits])

  # Some of these cases need to take into consideration overlapping edge cases.

  # E.g. "twone" should result in [2, 1], not [2] which you would get by the naive approach.
  def iterate_digits("one" <> _ = input, digits) do
    "on" <> rest = input
    iterate_digits(rest, [1 | digits])
  end

  def iterate_digits("two" <> _ = input, digits) do
    "tw" <> rest = input
    iterate_digits(rest, [2 | digits])
  end

  def iterate_digits("three" <> _ = input, digits) do
    "thre" <> rest = input
    iterate_digits(rest, [3 | digits])
  end

  def iterate_digits("four" <> rest, digits), do: iterate_digits(rest, [4 | digits])

  def iterate_digits("five" <> _ = input, digits) do
    "fiv" <> rest = input
    iterate_digits(rest, [5 | digits])
  end

  def iterate_digits("six" <> rest, digits), do: iterate_digits(rest, [6 | digits])

  def iterate_digits("seven" <> _ = input, digits) do
    "seve" <> rest = input

    iterate_digits(rest, [7 | digits])
  end

  def iterate_digits("eight" <> _ = input, digits) do
    "eigh" <> rest = input
    iterate_digits(rest, [8 | digits])
  end

  def iterate_digits("nine" <> _ = input, digits) do
    "nin" <> rest = input
    iterate_digits(rest, [9 | digits])
  end

  def iterate_digits(<<_char::utf8, rest::binary>>, digits) do
    iterate_digits(rest, digits)
  end
end
