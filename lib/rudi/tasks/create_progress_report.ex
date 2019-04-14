defmodule Rudi.Tasks.CreateProgressReport do
  alias Rudi.Drills
  alias Rudi.Insights

  def run(year, week, user_id) do
    changes = Drills.list_user_prompts(:year_week, user_id, year, week)
    |> Enum.reduce(%Rudi.Insights.ProgressReport{}, fn %{ insights: insights }, r ->
      r
      |> Map.put(:addition_average, (r.addition_count || 0) + insights["additions"])
      |> Map.put(:addition_count, (r.addition_count || 0) + insights["additions"])
      |> Map.put(:deletion_average, (r.addition_count || 0) + insights["additions"])
      |> Map.put(:deletion_count, (r.addition_count || 0) + insights["additions"])
      |> Map.put(:delta_max_avg, (r.addition_count || 0) + insights["additions"])
      |> Map.put(:delta_min_avg, (r.addition_count || 0) + insights["additions"])
    end)
    |> Map.put(:user_id, user_id)
    |> Map.put(:week, week)
    |> Map.put(:year, year)

    case Insights.get_progress_report!(:year_week, year, week, user_id) do
      nil -> %Rudi.Insights.ProgressReport{}
      existing_report -> existing_report
    end
    |> Insights.ProgressReport.changeset(changes |> Map.from_struct)
    |> Rudi.Repo.insert_or_update!
  end
end