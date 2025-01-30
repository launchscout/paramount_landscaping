defmodule ParamountLandscaping.Routes.Route do
  use Ecto.Schema
  import Ecto.Changeset

  schema "routes" do
    field :name, :string
    # Add any other existing fields here

    has_many :stops, ParamountLandscaping.Routes.Stop, on_replace: :delete
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(route, attrs) do
    route
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:stops, sort_param: :stops_order, drop_param: :stops_delete)
  end
end
