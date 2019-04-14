defmodule Rudi.Insights do
  @moduledoc """
  The Insights context.
  """

  import Ecto.Query, warn: false
  alias Rudi.Repo

  alias Rudi.Insights.ProgressReport

  @doc """
  Returns the list of progress_reports.

  ## Examples

      iex> list_progress_reports()
      [%ProgressReport{}, ...]

  """
  def list_progress_reports do
    Repo.all(ProgressReport)
  end

  @doc """
  Gets a single progress_report.

  Raises `Ecto.NoResultsError` if the Progress report does not exist.

  ## Examples

      iex> get_progress_report!(123)
      %ProgressReport{}

      iex> get_progress_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_progress_report!(id), do: Repo.get!(ProgressReport, id)

  def get_progress_report!(:public_id, public_id) do
    from(pr in ProgressReport, where: pr.public_id == ^public_id)
    |> Repo.one()
  end

  # Week format like 2019W02 ISO standard
  def get_progress_report!(:year_week, year, week, user_id) do
    from(pr in ProgressReport, where: pr.year == ^year and pr.week == ^week and pr.user_id == ^user_id)
    |> Repo.one()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking progress_report changes.

  ## Examples

      iex> change_progress_report(progress_report)
      %Ecto.Changeset{source: %ProgressReport{}}

  """
  def change_progress_report(%ProgressReport{} = progress_report) do
    ProgressReport.changeset(progress_report, %{})
  end
end
