defmodule Rudi.Repo.Migrations.CreateSkills do
  use Ecto.Migration

  def change do
    create table(:skills) do
      add :name, :string
      add :description, :text
      add :perspective, :string
      add :tense, :string
      add :weight, :integer

      timestamps()
    end

  end
end
