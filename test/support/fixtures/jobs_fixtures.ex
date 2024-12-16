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
        name: "some name",
        address: "some address",
        description: "some description",
        line_items: [],
        labors: []
      })
      |> ParamountLandscaping.Jobs.create_job()

    job
  end
end
