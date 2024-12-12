defmodule ParamountLandscaping.Labors do
  @moduledoc """
  The Labors context.
  """

  import Ecto.Query, warn: false
  alias ParamountLandscaping.Repo

  alias ParamountLandscaping.Labors.Labor

  @doc """
  Returns the list of labors.

  ## Examples

      iex> list_labors()
      [%Labor{}, ...]

  """
  def list_labors do
    Repo.all(Labor)
  end

  @doc """
  Gets a single labor.

  Raises `Ecto.NoResultsError` if the Labor does not exist.

  ## Examples

      iex> get_labor!(123)
      %Labor{}

      iex> get_labor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_labor!(id), do: Repo.get!(Labor, id)

  @doc """
  Creates a labor.

  ## Examples

      iex> create_labor(%{field: value})
      {:ok, %Labor{}}

      iex> create_labor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_labor(attrs \\ %{}) do
    %Labor{}
    |> Labor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a labor.

  ## Examples

      iex> update_labor(labor, %{field: new_value})
      {:ok, %Labor{}}

      iex> update_labor(labor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_labor(%Labor{} = labor, attrs) do
    labor
    |> Labor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a labor.

  ## Examples

      iex> delete_labor(labor)
      {:ok, %Labor{}}

      iex> delete_labor(labor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_labor(%Labor{} = labor) do
    Repo.delete(labor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking labor changes.

  ## Examples

      iex> change_labor(labor)
      %Ecto.Changeset{data: %Labor{}}

  """
  def change_labor(%Labor{} = labor, attrs \\ %{}) do
    Labor.changeset(labor, attrs)
  end
end
