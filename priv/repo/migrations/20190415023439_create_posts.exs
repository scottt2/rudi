defmodule Rudi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :display_name, :string
      add :slug, :string
      add :body, :text
      add :published_at, :naive_datetime
      add :tags, {:array, :string}
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:user_id])
  end
end
