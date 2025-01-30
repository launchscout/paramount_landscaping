defmodule ParamountLandscaping.Routes.Stop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stops" do
    field :name, :string
    field :address, :string
    field :walk, :boolean, default: false
    field :capacity, :integer

    belongs_to :route, ParamountLandscaping.Routes.Route
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stop, attrs) do
    stop
    |> cast(attrs, [:name, :address, :walk, :route_id, :capacity])
    |> validate_required([:name, :address, :walk])
    |> foreign_key_constraint(:route_id)
  end
end
