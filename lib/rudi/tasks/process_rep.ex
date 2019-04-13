defmodule Rudi.Tasks.ProcessRep do
  def run(%Rudi.Drills.UserPrompt{
    body: body,
    interupt_count: interupt_count,
    socket_id: socket_id,
    typings: typings
  }) do
    results = %{
      additions: 0,
      deletions: 0,
      delta_max: 0,
      delta_min: 300_000, # 5 minutes in ms
      last_ts: 0,
      strokes: 0,
    }
    results =
      typings
      |> Enum.chunk_every(3)
      |> Enum.reduce(results, fn [ts, addition, char], r ->
        r
        |> Map.put(:additions, r.additions + addition)
        |> Map.put(:deletions, r.deletions + (if (addition < 1), do: 1, else: 0))
        |> Map.put(:delta_max, max(r.delta_max, r.last_ts - ts))
        |> Map.put(:delta_min, min(r.delta_min, abs(r.last_ts - ts)))
        |> Map.put(:last_ts, ts)
        |> Map.put(:strokes, r.strokes + 1)
      end)

    IO.puts inspect results
  end
end