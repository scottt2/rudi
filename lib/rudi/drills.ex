defmodule Rudi.Drills do
  @moduledoc """
  The Drills context.
  """

  import Ecto.Query, warn: false
  alias Rudi.Repo

  alias Rudi.Accounts
  alias Rudi.Drills.Seed

  @doc """
  Returns the list of seeds.

  ## Examples

      iex> list_seeds()
      [%Seed{}, ...]

  """
  def list_seeds do
    Repo.all(Seed)
  end

  @doc """
  Gets a single seed.

  Raises `Ecto.NoResultsError` if the Seed does not exist.

  ## Examples

      iex> get_seed!(123)
      %Seed{}

      iex> get_seed!(456)
      ** (Ecto.NoResultsError)

  """
  def get_seed!(id), do: Repo.get!(Seed, id)

  def get_seed_by_public_id!(public_id) do
    from(s in Seed, where: s.public_id == ^public_id) #, preload: :seeds)
    |> Repo.one()
  end

  def get_random_seed! do
    from(s in Seed, where: s.promptable == true, order_by: fragment("RANDOM()"), limit: 1)
    |> Repo.one()
  end

  @doc """
  Creates a seed.

  ## Examples

      iex> create_seed(%{field: value})
      {:ok, %Seed{}}

      iex> create_seed(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_seed(%Accounts.User{} = user, attrs \\ %{}) do
    %Seed{}
    |> Seed.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:author, user)
    |> Repo.insert()
  end

  @doc """
  Updates a seed.

  ## Examples

      iex> update_seed(seed, %{field: new_value})
      {:ok, %Seed{}}

      iex> update_seed(seed, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_seed(%Seed{} = seed, attrs) do
    seed
    |> Seed.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Seed.

  ## Examples

      iex> delete_seed(seed)
      {:ok, %Seed{}}

      iex> delete_seed(seed)
      {:error, %Ecto.Changeset{}}

  """
  def delete_seed(%Seed{} = seed) do
    Repo.delete(seed)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking seed changes.

  ## Examples

      iex> change_seed(seed)
      %Ecto.Changeset{source: %Seed{}}

  """
  def change_seed(%Seed{} = seed) do
    Seed.changeset(seed, %{})
  end

  defp put_author(changeset, user) do
    Ecto.Changeset.put_assoc(changeset, :author, user)
  end

  defp scope_query_to_user(query, %Accounts.User{id: user_id}) do
    from(m in query, where: m.user_id == ^user_id)
  end

  alias Rudi.Drills.Skill

  @doc """
  Returns the list of skills.

  ## Examples

      iex> list_skills()
      [%Skill{}, ...]

  """
  def list_skills do
    Repo.all(Skill)
  end

  @doc """
  Gets a single skill.

  Raises `Ecto.NoResultsError` if the Skill does not exist.

  ## Examples

      iex> get_skill!(123)
      %Skill{}

      iex> get_skill!(456)
      ** (Ecto.NoResultsError)

  """
  def get_skill!(id), do: Repo.get!(Skill, id)

  def get_random_skill! do
    (from Skill, order_by: fragment("RANDOM()"), limit: 1)
    |> Repo.one()
  end

  @doc """
  Creates a skill.

  ## Examples

      iex> create_skill(%{field: value})
      {:ok, %Skill{}}

      iex> create_skill(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_skill(attrs \\ %{}) do
    %Skill{}
    |> Skill.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a skill.

  ## Examples

      iex> update_skill(skill, %{field: new_value})
      {:ok, %Skill{}}

      iex> update_skill(skill, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_skill(%Skill{} = skill, attrs) do
    skill
    |> Skill.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Skill.

  ## Examples

      iex> delete_skill(skill)
      {:ok, %Skill{}}

      iex> delete_skill(skill)
      {:error, %Ecto.Changeset{}}

  """
  def delete_skill(%Skill{} = skill) do
    Repo.delete(skill)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking skill changes.

  ## Examples

      iex> change_skill(skill)
      %Ecto.Changeset{source: %Skill{}}

  """
  def change_skill(%Skill{} = skill) do
    Skill.changeset(skill, %{})
  end

  alias Rudi.Drills.Prompt

  @doc """
  Returns the list of prompts.

  ## Examples

      iex> list_prompts()
      [%Prompt{}, ...]

  """
  def list_prompts do
    Repo.all(Prompt)
  end

  @doc """
  Gets a single prompt.

  Raises `Ecto.NoResultsError` if the Prompt does not exist.

  ## Examples

      iex> get_prompt!(123)
      %Prompt{}

      iex> get_prompt!(456)
      ** (Ecto.NoResultsError)

  """
  def get_prompt!(id), do: Repo.get!(Prompt, id)

  def get_prompt_by_public_id!(public_id) do
    from(p in Prompt, where: p.public_id == ^public_id, preload: [:seed, :skill])
    |> Repo.one()
  end

  def get_prompt_for_date!(date) do
    from(p in Prompt, where: p.of_the_day == ^date)
    |> Repo.one()
  end

  def get_prompt_for_date!(:include_associations, date) do
    from(p in Prompt, where: p.of_the_day == ^date, preload: [:seed, :skill])
    |> Repo.one()
  end

  @doc """
  Creates a prompt.

  ## Examples

      iex> create_prompt(%{field: value})
      {:ok, %Prompt{}}

      iex> create_prompt(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prompt(attrs \\ %{}) do
    %Prompt{}
    |> Prompt.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a prompt.

  ## Examples

      iex> update_prompt(prompt, %{field: new_value})
      {:ok, %Prompt{}}

      iex> update_prompt(prompt, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prompt(%Prompt{} = prompt, attrs) do
    prompt
    |> Prompt.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Prompt.

  ## Examples

      iex> delete_prompt(prompt)
      {:ok, %Prompt{}}

      iex> delete_prompt(prompt)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prompt(%Prompt{} = prompt) do
    Repo.delete(prompt)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prompt changes.

  ## Examples

      iex> change_prompt(prompt)
      %Ecto.Changeset{source: %Prompt{}}

  """
  def change_prompt(%Prompt{} = prompt) do
    Prompt.changeset(prompt, %{})
  end
end

