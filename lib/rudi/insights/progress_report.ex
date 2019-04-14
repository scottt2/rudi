defmodule Rudi.Insights.ProgressReport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "progress_reports" do
    field :addition_average, :float
    field :addition_count, :integer
    field :deletion_average, :float
    field :deletion_count, :integer
    field :delta_max_avg, :float
    field :delta_min_avg, :float
    field :public, :boolean, default: false
    field :public_id, Ecto.UUID
    field :week, :integer
    field :year, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(progress_report, attrs) do
    progress_report
    |> cast(attrs, [:week, :year, :addition_count, :addition_average, :deletion_count, :deletion_average, :delta_min_avg, :delta_max_avg,])
    |> validate_required([:week, :year, :addition_count, :addition_average, :deletion_count, :deletion_average, :delta_min_avg, :delta_max_avg,])
  end
end
