defmodule ParamountLandscaping.LineItems.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "line_items" do
    field :total, :integer
    field :material, :string
    field :unit_cost, :integer
    field :quantity, :decimal

    belongs_to :job, ParamountLandscaping.Jobs.Job

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [:material, :unit_cost, :quantity, :total, :job_id])
    |> validate_required([:material, :unit_cost, :quantity, :total, :job_id])
  end
end
