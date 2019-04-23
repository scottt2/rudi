defmodule Rudi.Responses do
  @moduledoc """
  The Responses context.
  """

  import Ecto.Query, warn: false
  alias Rudi.Repo

  alias Rudi.Accounts
  alias Rudi.Responses.UserPrompt

  @doc """
  Returns the list of user_prompts.

  ## Examples

      iex> list_user_prompts()
      [%UserPrompt{}, ...]

  """
  def list_user_prompts do
    Repo.all(UserPrompt)
  end

  def list_user_prompts(:year_week, user_id, year, week) do
    start_utc = Timex.from_iso_triplet({year, week, 1}) |> Timex.to_datetime
    end_utc =
      Timex.from_iso_triplet({year, week, 7})
      |> Timex.to_datetime
      |> Timex.end_of_day
    from(
      up in UserPrompt,
      where: up.user_id == ^user_id
      and up.start_at_utc >= ^start_utc
      and up.start_at_utc <= ^end_utc
    )
    |> Repo.all()
  end

  def list_user_prompts_for_user_and_prompt(user, prompt) do
    from(
      up in UserPrompt,
      where: up.user_id == ^user.id and up.prompt_id == ^prompt.id
    )
    |> Repo.all()
  end

  def get_active_user_prompt(user, prompt) do
    from(
      up in UserPrompt,
      where: up.user_id == ^user.id and up.prompt_id == ^prompt.id and up.active == true
    )
    |> Repo.one()
  end

  def get_active_user_prompt(:with_ids, user_id, prompt_id) do
    {:ok, prompt_id} = Ecto.UUID.cast(prompt_id)
    # Repo.get_by(Rudi.Drills.UserPrompt, active: true, user_id: user_id)
    from(
      up in UserPrompt,
      where: up.user_id == ^user_id and up.active == true
    )
    |> Repo.one()
  end

  def list_completed_user_prompts(user, prompt) do
    from(
      up in UserPrompt,
      where: up.user_id == ^user.id and up.prompt_id == ^prompt.id and not is_nil(up.end_at_utc)
    )
    |> order_by(asc: :id)
    |> Repo.all()
  end

  @doc """
  Gets a single user_prompt.

  Raises `Ecto.NoResultsError` if the User prompt does not exist.

  ## Examples

      iex> get_user_prompt!(123)
      %UserPrompt{}

      iex> get_user_prompt!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_prompt!(id), do: Repo.get!(UserPrompt, id)

  @doc """
  Creates a user_prompt.

  ## Examples

      iex> create_user_prompt(%{field: value})
      {:ok, %UserPrompt{}}

      iex> create_user_prompt(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_prompt(attrs \\ %{}) do
    %UserPrompt{}
    |> UserPrompt.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_prompt.

  ## Examples

      iex> update_user_prompt(user_prompt, %{field: new_value})
      {:ok, %UserPrompt{}}

      iex> update_user_prompt(user_prompt, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_prompt(%UserPrompt{} = user_prompt, attrs) do
    user_prompt
    |> UserPrompt.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserPrompt.

  ## Examples

      iex> delete_user_prompt(user_prompt)
      {:ok, %UserPrompt{}}

      iex> delete_user_prompt(user_prompt)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_prompt(%UserPrompt{} = user_prompt) do
    Repo.delete(user_prompt)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_prompt changes.

  ## Examples

      iex> change_user_prompt(user_prompt)
      %Ecto.Changeset{source: %UserPrompt{}}

  """
  def change_user_prompt(%UserPrompt{} = user_prompt) do
    UserPrompt.changeset(user_prompt, %{})
  end
end
