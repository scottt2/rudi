defmodule Rudi.Repo.Migrations.CreateSeeds do
  use Ecto.Migration

  def change do
    create table(:seeds) do
      add :body, :text
      add :public, :boolean, default: false
      add :promptable, :boolean, default: false
      add :public_id, :uuid, null: false
      add :author_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:seeds, [:author_id])
    create index(:seeds, [:public_id])
  end
end
