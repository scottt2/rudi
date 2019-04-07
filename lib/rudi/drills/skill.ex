defmodule Rudi.Drills.Skill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skills" do
    field :description, :string
    field :name, :string
    field :perspective, :string
    field :tense, :string
    field :weight, :integer

    timestamps()
  end

  @doc false
  def changeset(skill, attrs) do
    skill
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
