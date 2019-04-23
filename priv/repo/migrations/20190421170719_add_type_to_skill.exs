defmodule Rudi.Repo.Migrations.AddTypeToSkill do
  use Ecto.Migration

  def change do
    alter table(:skills) do
      add :type, :string
    end
  end
end
