defmodule Rudi.Repo.Migrations.AddInsightsToUserPrompt do
  use Ecto.Migration

  def change do
    alter table(:user_prompts) do
      add :insights, :map
    end
  end
end
