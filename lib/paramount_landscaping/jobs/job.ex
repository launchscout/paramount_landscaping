defmodule ParamountLandscaping.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :name, :string
    field :address, :string
    field :description, :string

    has_many :line_items, ParamountLandscaping.LineItems.LineItem, on_replace: :delete
    has_many :labors, ParamountLandscaping.Labors.Labor, on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:address, :name, :description])
    |> validate_required([:address, :name, :description])
    |> cast_assoc(:line_items, sort_param: :line_items_order, drop_param: :line_items_delete)
    |> cast_assoc(:labors, sort_param: :labor_order, drop_param: :labor_delete)
  end

end
