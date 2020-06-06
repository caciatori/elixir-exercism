defmodule RobotSimulator do
  alias RobotSimulator

  @valid_directions ~w(north east south west)a
  defguard direction_valid?(direction) when direction in @valid_directions

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(:atom | nil, {any, any} | nil) ::
          {:east, {any, any}}
          | {:north, {any, any}}
          | {:south, {any, any}}
          | {:west, {any, any}}
          | {:error, String.t()}
  def create(direction \\ nil, position \\ nil)

  def create(nil, nil), do: {:north, {0, 0}}

  def create(direction, {x, y}) when direction_valid?(direction) do
    if is_integer(x) and is_integer(y) do
      {direction, {x, y}}
    else
      {:error, "invalid position"}
    end
  end

  def create(direction, _position) when not direction_valid?(direction) do
    {:error, "invalid direction"}
  end

  def create(_direction, _position), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    if String.match?(instructions, ~r/[RLA]+$/) do
      move(robot, instructions)
    else
      {:error, "invalid instruction"}
    end
  end

  defp move(robot, instructions) do
    turns = [
      north: %{"L" => :west, "R" => :east},
      east: %{"L" => :north, "R" => :south},
      south: %{"L" => :east, "R" => :west},
      west: %{"L" => :south, "R" => :north}
    ]

    instructions
    |> String.codepoints()
    |> Enum.reduce(robot, fn instruction, acc ->
      if instruction in ["L", "R"] do
        {direction, position} = acc
        {turns[direction][instruction], position}
      else
        advance(acc)
      end
    end)
  end

  defp advance({direction, {x, y}}) do
    cond do
      direction == :north -> {direction, {x, y + 1}}
      direction == :south -> {direction, {x, y - 1}}
      direction == :east -> {direction, {x + 1, y}}
      direction == :west -> {direction, {x - 1, y}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _position}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_direction, position}), do: position
end
