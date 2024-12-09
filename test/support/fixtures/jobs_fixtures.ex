defmodule ParamountLandscaping.JobsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ParamountLandscaping.Jobs` context.
  """

  @doc """
  Generate a job.
  """
  def job_fixture(attrs \\ %{}) do
    {:ok, job} =
      attrs
      |> Enum.into(%{
        address: "some address",
        description: "some description",
        name: "some name"
      })
      |> ParamountLandscaping.Jobs.create_job()

    job
  end
end
