defmodule ParamountLandscaping.Labors.Labor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "labors" do
    field :worker, :string
    field :hours, :decimal
    field :per_hour_cost, :integer

    belongs_to :job, ParamountLandscaping.Jobs.Job

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(labor, attrs) do
    labor
    |> cast(attrs, [:worker, :hours, :per_hour_cost])
    |> validate_required([:worker, :hours, :per_hour_cost])
  end
end
