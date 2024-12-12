defmodule ParamountLandscaping.LaborsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ParamountLandscaping.Labors` context.
  """

  @doc """
  Generate a labor.
  """
  def labor_fixture(attrs \\ %{}) do
    {:ok, labor} =
      attrs
      |> Enum.into(%{
        hours: "120.5",
        per_hour_cost: 42,
        worker: "some worker"
      })
      |> ParamountLandscaping.Labors.create_labor()

    labor
  end
end
