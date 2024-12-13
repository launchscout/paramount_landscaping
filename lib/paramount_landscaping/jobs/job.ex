defmodule ParamountLandscaping.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :name, :string
    field :address, :string
    field :description, :string

    has_many :line_items, ParamountLandscaping.LineItems.LineItem, on_replace: :delete
    has_many :labors, ParamountLandscaping.Labors.Labor, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:name, :address, :description])
    |> validate_required([:name, :address])
    |> cast_assoc(:line_items, with: &ParamountLandscaping.LineItems.LineItem.changeset/2)
    |> cast_assoc(:labors, with: &ParamountLandscaping.Labors.Labor.changeset/2)
  end
end
