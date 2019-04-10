defmodule Rudi.Repo.Migrations.CreateUserPrompts do
  use Ecto.Migration

  def change do
    create table(:user_prompts) do
      add :user_id, references(:users, on_delete: :nothing)
      add :prompt_id, references(:prompts, on_delete: :nothing)
      add :start_at_utc, :utc_datetime
      add :start_at_device_epoch, :decimal
      add :end_at_utc, :utc_datetime
      add :end_at_device_epoch, :decimal
      add :active, :boolean, default: false
      add :interupt_count, :integer, default: 0
      add :body, :text
      add :typings, {:array, :integer}
      add :socket_id, :text

      timestamps()
    end

    create index(:user_prompts, [:user_id])
    create index(:user_prompts, [:prompt_id])
  end
end
