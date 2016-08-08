defmodule Collatz do
  def stream(initial_number) do
    Stream.resource(
      fn -> initial_number end,
      fn(current_number) ->
        cond do
          rem(current_number, 2) == 0 ->
            divide_by_two_or_halt(current_number)
          true ->
            n3plus1(current_number)
        end
      end,
      fn(number) -> number end
    )
  end

  defp divide_by_two_or_halt(number) do
    half = div(number, 2)
    {[half], half}
  end

  defp n3plus1(number) do
    n3plus1 = 3 * number + 1

    case number do
      1 -> {:halt, number}
      _ -> {[n3plus1], n3plus1}
    end
  end
end
