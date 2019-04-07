defmodule Rudi.Repo.Migrations.CreatePrompts do
  use Ecto.Migration

  def change do
    create table(:prompts) do
      add :seed_id, references(:seeds, on_delete: :nothing)
      add :skill_id, references(:skills, on_delete: :nothing)
      add :of_the_day, :date
      add :public_id, :uuid, null: false

      timestamps()
    end

    create index(:prompts, [:seed_id])
    create index(:prompts, [:skill_id])
  end
end
