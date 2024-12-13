defmodule ParamountLandscaping.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :name, :string
    field :address, :string
    field :description, :string

    has_many :line_items, ParamountLandscaping.LineItems.LineItem
    has_many :labors, ParamountLandscaping.Labors.Labor

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:address, :name, :description])
    |> validate_required([:address, :name, :description])
    |> cast_assoc(:line_items, sort_param: :line_items_order, drop_param: :delete)
    |> cast_assoc(:labors, sort_param: :labor_order, drop_param: :labor_delete)
  end

  def calculate_labor_total(job) do
    Enum.reduce(job.labors, Decimal.new(0), fn labor, acc ->
      labor_cost = Decimal.mult(Decimal.new(labor.hours), Decimal.new(labor.per_hour_cost))
      Decimal.add(acc, labor_cost)
    end)
  end

  def calculate_materials_total(job) do
    Enum.reduce(job.line_items, Decimal.new(0), fn item, acc ->
      Decimal.add(acc, item.total)
    end)
  end

  def calculate_job_total(job) do
    labor_total = calculate_labor_total(job)
    materials_total = calculate_materials_total(job)
    Decimal.add(labor_total, materials_total)
  end
end
