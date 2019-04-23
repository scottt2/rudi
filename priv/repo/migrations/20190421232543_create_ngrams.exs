defmodule Rudi.Repo.Migrations.CreateNgrams do
  use Ecto.Migration

  def change do
    create table(:ngrams) do
      add :n, :integer
      add :gram_type, :string
      add :frequency, :integer
      add :body, :text

      timestamps()
    end

  end
end
