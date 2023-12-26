import AOC

aoc 2023, 2 do
  @moduledoc """
  https://adventofcode.com/2023/day/2
  """
  defmodule Game do
    use TypedStruct

    @type colours :: %{String.t() => integer()}

    typedstruct enforce: true do
      field(:id, integer())
      field(:max_seen_colours, colours)
    end

    def init(input) do
      {id, max_seen_colours} = parse_game(input)

      %__MODULE__{id: id, max_seen_colours: max_seen_colours}
    end

    defp parse_game("Game " <> game) do
      [id, reveals] =
        game
        |> String.split(":")
        |> Enum.map(&String.trim/1)

      id = String.to_integer(id)

      colours =
        reveals
        |> String.split(";")
        |> Enum.map(&String.split(&1, ","))
        |> List.flatten()
        |> Enum.map(&String.trim/1)

      init_max_seen = %{"red" => 0, "green" => 0, "blue" => 0}

      max_seen =
        colours
        |> Enum.map(&String.split/1)
        |> Enum.reduce(init_max_seen, fn [count, colour], max_seen ->
          count = String.to_integer(count)

          Map.update!(max_seen, colour, fn
            max when max > count -> max
            _ -> count
          end)
        end)

      {id, max_seen}
    end

    def possible?(game, colours) do
      Enum.all?(game.max_seen_colours, fn {colour, count} ->
        count <= Map.get(colours, colour)
      end)
    end
  end

  @doc """
      iex> p1(example_input())
  """
  def p1(input) do
    actual_max = %{"red" => 12, "green" => 13, "blue" => 14}

    input
    |> String.split("\n")
    |> Enum.map(&Game.init/1)
    |> Enum.filter(&Game.possible?(&1, actual_max))
    |> Enum.map(& &1.id)
    |> Enum.sum()
  end

  @doc """
      iex> p2(example_input())
  """
  def p2(input) do
    input
    |> String.split("\n")
    |> Enum.map(&Game.init/1)
    |> Enum.map(fn game ->
      # Calculate power
      game.max_seen_colours
      |> Map.values()
      |> Enum.product()
    end)
    |> Enum.sum()
  end
end
