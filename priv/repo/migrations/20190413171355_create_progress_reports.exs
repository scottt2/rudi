defmodule Rudi.Repo.Migrations.CreateProgressReports do
  use Ecto.Migration

  def change do
    create table(:progress_reports) do
      add :week, :integer
      add :year, :integer
      add :addition_count, :integer
      add :addition_average, :float
      add :deletion_count, :integer
      add :deletion_average, :float
      add :delta_min_avg, :float
      add :delta_max_avg, :float
      add :public, :boolean, default: false, null: false
      add :public_id, :uuid
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:progress_reports, [:user_id])
  end
end
