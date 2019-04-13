defmodule Rudi.Tasks.ProcessRep do
  def run(user_prompt) do
    results = %{
      additions: 0,
      deletions: 0,
      delta_max: 0,
      delta_min: 300_000, # 5 minutes in ms
      last_ts: 0,
      strokes: 0,
    }
    results =
      user_prompt.typings
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

    updated_up = user_prompt |> Ecto.Changeset.change(insights: results)
    case Rudi.Repo.update(updated_up) do
      {:ok, updated_up} -> RudiWeb.Endpoint.broadcast(updated_up.socket_id, "rep:processed", updated_up)
      {:error, _} -> :error
    end
  end
end