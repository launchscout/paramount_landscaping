defmodule ParamountLandscaping.Jobs do
  @moduledoc """
  The Jobs context.
  """

  import Ecto.Query, warn: false
  alias ParamountLandscaping.Repo

  alias ParamountLandscaping.Jobs.Job

  @doc """
  Returns the list of jobs.

  ## Examples

      iex> list_jobs()
      [%Job{}, ...]

  """
  def list_jobs(opts \\ []) do
    Job
    |> preload_associations(opts)
    |> Repo.all()
  end

  @doc """
  Gets a single job.

  Raises `Ecto.NoResultsError` if the Job does not exist.

  ## Examples

      iex> get_job!(123)
      %Job{}

      iex> get_job!(456)
      ** (Ecto.NoResultsError)

  """
  def get_job!(id, opts \\ []) do
    Job
    |> preload_associations(opts)
    |> Repo.get!(id)
  end

  @doc """
  Creates a job.

  ## Examples

      iex> create_job(%{field: value})
      {:ok, %Job{}}

      iex> create_job(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_job(attrs \\ %{}) do
    %Job{}
    |> Job.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a job.

  ## Examples

      iex> update_job(job, %{field: new_value})
      {:ok, %Job{}}

      iex> update_job(job, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_job(%Job{} = job, attrs) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a job.

  ## Examples

      iex> delete_job(job)
      {:ok, %Job{}}

      iex> delete_job(job)
      {:error, %Ecto.Changeset{}}

  """
  def delete_job(%Job{} = job) do
    Repo.delete(job)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job changes.

  ## Examples

      iex> change_job(job)
      %Ecto.Changeset{data: %Job{}}

  """
  def change_job(%Job{} = job, attrs \\ %{}) do
    Job.changeset(job, attrs)
  end

  # Private helper to handle preloading
  defp preload_associations(query, opts) do
    case Keyword.get(opts, :preload) do
      nil -> query
      preloads -> from(q in query, preload: ^preloads)
    end
  end

  def calculate_labor_total(job) do
    Enum.reduce(job.labors, Decimal.new(0), fn labor, acc ->
      labor_cost = Decimal.mult(Decimal.new(labor.hours), Decimal.new(labor.per_hour_cost))
      Decimal.add(acc, labor_cost)
    end)
  end

  def calculate_materials_total(job) do
    Enum.reduce(job.line_items, Decimal.new(0), fn item, acc ->
      Decimal.add(acc, item.total)
    end)
  end

  def calculate_job_total(job) do
    labor_total = calculate_labor_total(job)
    materials_total = calculate_materials_total(job)
    Decimal.add(labor_total, materials_total)
  end
end
