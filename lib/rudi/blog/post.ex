defmodule Rudi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :slug, :string
    field :display_name, :string
    field :published_at, :naive_datetime
    field :tags, {:array, :string}
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:display_name, :body, :published_at, :tags])
    |> validate_required([:display_name, :body])
  end
end
