defmodule Rudi.Drills.Prompt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prompts" do
    belongs_to :seed, Rudi.Drills.Seed
    belongs_to :skill, Rudi.Drills.Skill

    field :of_the_day, :date
    field :public_id, Ecto.UUID, autogenerate: true

    timestamps()
  end

  @doc false
  def changeset(prompt, attrs) do
    prompt
    |> cast(attrs, [])
    |> validate_required([])
  end
end
