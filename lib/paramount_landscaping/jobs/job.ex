defmodule ParamountLandscaping.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :name, :string
    field :address, :string
    field :description, :string

    has_many :line_items, ParamountLandscaping.LineItems.LineItem

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:address, :name, :description])
    |> validate_required([:address, :name, :description])
  end
end
