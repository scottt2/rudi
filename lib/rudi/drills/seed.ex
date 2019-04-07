defmodule Rudi.Drills.Seed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seeds" do
    belongs_to :author, Rudi.Accounts.User

    field :body, :string
    field :public, :boolean, default: false
    field :public_id, Ecto.UUID, autogenerate: true
    field :promptable, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(seed, attrs) do
    seed
    |> cast(attrs, [:body, :public])
    |> validate_required([:body, :public])
  end
end
