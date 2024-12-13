defmodule ParamountLandscaping.LineItems.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "line_items" do
    field :total, :decimal
    field :material, :string
    field :unit_cost, :integer
    field :quantity, :decimal

    belongs_to :job, ParamountLandscaping.Jobs.Job

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [:material, :unit_cost, :quantity, :total])
    |> validate_required([:material, :unit_cost, :quantity])
    |> calculate_total()
  end

  defp calculate_total(changeset) do
    case {get_field(changeset, :quantity), get_field(changeset, :unit_cost)} do
      {quantity, unit_cost} when not is_nil(quantity) and not is_nil(unit_cost) ->
        total =
          quantity
          |> Decimal.mult(unit_cost)

        put_change(changeset, :total, total)

      _ ->
        changeset
    end
  end
end
