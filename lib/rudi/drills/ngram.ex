defmodule Rudi.Drills.Ngram do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ngrams" do
    field :body, :string
    field :frequency, :integer
    field :gram_type, :string
    field :n, :integer

    timestamps()
  end

  @doc false
  def changeset(ngram, attrs) do
    ngram
    |> cast(attrs, [:n, :gram_type, :frequency, :body])
    |> validate_required([:n, :gram_type, :frequency, :body])
  end
end
