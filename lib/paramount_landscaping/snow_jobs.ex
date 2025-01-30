defmodule ParamountLandscaping.SnowJobs do
  @moduledoc """
  The SnowJobs context.
  """

  import Ecto.Query, warn: false
  alias ParamountLandscaping.Repo

  alias ParamountLandscaping.SnowJobs.SnowJob

  @doc """
  Returns the list of snow_jobs.

  ## Examples

      iex> list_snow_jobs()
      [%SnowJob{}, ...]

  """
  def list_snow_jobs do
    Repo.all(SnowJob)
  end

  @doc """
  Gets a single snow_job.

  Raises `Ecto.NoResultsError` if the Snow job does not exist.

  ## Examples

      iex> get_snow_job!(123)
      %SnowJob{}

      iex> get_snow_job!(456)
      ** (Ecto.NoResultsError)

  """
  def get_snow_job!(id), do: Repo.get!(SnowJob, id)

  @doc """
  Creates a snow_job.

  ## Examples

      iex> create_snow_job(%{field: value})
      {:ok, %SnowJob{}}

      iex> create_snow_job(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_snow_job(attrs \\ %{}) do
    %SnowJob{}
    |> SnowJob.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a snow_job.

  ## Examples

      iex> update_snow_job(snow_job, %{field: new_value})
      {:ok, %SnowJob{}}

      iex> update_snow_job(snow_job, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_snow_job(%SnowJob{} = snow_job, attrs) do
    snow_job
    |> SnowJob.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a snow_job.

  ## Examples

      iex> delete_snow_job(snow_job)
      {:ok, %SnowJob{}}

      iex> delete_snow_job(snow_job)
      {:error, %Ecto.Changeset{}}

  """
  def delete_snow_job(%SnowJob{} = snow_job) do
    Repo.delete(snow_job)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking snow_job changes.

  ## Examples

      iex> change_snow_job(snow_job)
      %Ecto.Changeset{data: %SnowJob{}}

  """
  def change_snow_job(%SnowJob{} = snow_job, attrs \\ %{}) do
    SnowJob.changeset(snow_job, attrs)
  end
end
