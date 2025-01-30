defmodule ParamountLandscaping.SnowJobsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ParamountLandscaping.SnowJobs` context.
  """

  @doc """
  Generate a snow_job.
  """
  def snow_job_fixture(attrs \\ %{}) do
    {:ok, snow_job} =
      attrs
      |> Enum.into(%{
        date: ~D[2025-01-29]
      })
      |> ParamountLandscaping.SnowJobs.create_snow_job()

    snow_job
  end
end
