defmodule Rudi.Drills.UserPrompt do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [
    :__meta__, :id, :prompt, :prompt_id, :typings, :user, :user_id]}

  schema "user_prompts" do
    belongs_to :prompt, Rudi.Drills.Prompt
    belongs_to :user, Rudi.Accounts.User

    field :active, :boolean, default: false
    field :typings, {:array, :integer}
    field :end_at_device_epoch, :decimal
    field :end_at_utc, :utc_datetime
    field :interupt_count, :integer, default: 0
    field :body, :string
    field :start_at_device_epoch, :decimal
    field :start_at_utc, :utc_datetime
    field :socket_id, :string
    field :insights, :map

    timestamps()
  end

  @doc false
  def changeset(user_prompt, attrs) do
    user_prompt
    |> cast(attrs, [:start_at_utc, :start_at_device_epoch, :end_at_utc, :end_at_device_epoch, :active, :interupt_count, :result, :data])
    |> validate_required([:start_at_utc, :start_at_device_epoch, :end_at_utc, :end_at_device_epoch, :active, :interupt_count, :result, :data])
  end
end
