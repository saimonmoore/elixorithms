defmodule Collatz do

  # TODO: Make a proper working graph that reuses existing branches
  def graph(max) do
    cycle_until(max, fn(number, accumulator) ->
      cond do
        rem(number, 2) == 0 ->
          IO.write("#{number}\n|\nv\n#{accumulator}")
        true ->
          IO.write("#{number} -> #{accumulator}\n")
      end
    end)
  end

  def max_cycles_for(max) do
    cycles_for(max, fn(stream) ->
     stream |> Enum.to_list |> length
    end) |> Enum.max_by(fn(cn) -> elem(cn, 1) end) |> elem(0)
  end

  def stream(initial_number) do
    Collatz.stream(initial_number, &Collatz.callback/2)
  end

  def stream(initial_number, fun) do
    Stream.resource(
      fn -> initial_number end,
      fn(current_number) ->
        cond do
          rem(current_number, 2) == 0 ->
            divide_by_two_or_halt(current_number, fun)
          true ->
            n3plus1(current_number, fun)
        end
      end,
      fn(number) -> number end
    )
  end

  def callback(number, accumulator) do
    {number, accumulator}
  end

  defp divide_by_two_or_halt(number, fun) do
    half = div(number, 2)
    fun.(number, half)
    {[half], half}
  end

  defp n3plus1(number, fun) do
    n3plus1 = 3 * number + 1

    fun.(number, n3plus1)
    case number do
      1 -> {:halt, number}
      _ -> {[n3plus1], n3plus1}
    end
  end

  defp cycle_until(max, fun) do
    2..max |> Enum.map(fn(cycle) ->
      Collatz.stream(cycle, fun) |> Stream.run
    end)
  end

  defp cycles_for(max, reducer) do
    2..max |> Enum.map(fn(cycle) ->
      {cycle, Collatz.stream(cycle, &Collatz.callback/2) |> reducer.()}
    end)
  end
end
