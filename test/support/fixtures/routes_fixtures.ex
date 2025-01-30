defmodule ParamountLandscaping.RoutesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ParamountLandscaping.Routes` context.
  """

  @doc """
  Generate a route.
  """
  def route_fixture(attrs \\ %{}) do
    {:ok, route} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> ParamountLandscaping.Routes.create_route()

    route
  end

  @doc """
  Generate a stop.
  """
  def stop_fixture(attrs \\ %{}) do
    {:ok, stop} =
      attrs
      |> Enum.into(%{
        address: "some address",
        name: "some name",
        walk: true
      })
      |> ParamountLandscaping.Routes.create_stop()

    stop
  end
end
