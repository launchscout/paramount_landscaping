defmodule ParamountLandscaping.LineItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ParamountLandscaping.LineItems` context.
  """

  @doc """
  Generate a line_item.
  """
  def line_item_fixture(attrs \\ %{}) do
    {:ok, line_item} =
      attrs
      |> Enum.into(%{
        material: "some material",
        quantity: "120.5",
        total: 42,
        unit_cost: 42
      })
      |> ParamountLandscaping.LineItems.create_line_item()

    line_item
  end
end
