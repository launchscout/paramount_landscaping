defmodule ParamountLandscaping.Stops.Stop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stops" do
    field :name, :string
    # Add any other existing fields here

    belongs_to :route, ParamountLandscaping.Routes.Route
    timestamps()
  end

  def changeset(stop, attrs) do
    stop
    |> cast(attrs, [:name, :route_id]) # Add other fields to the cast
    |> validate_required([:name, :route_id]) # Add other required fields
    |> foreign_key_constraint(:route_id)
  end
end
