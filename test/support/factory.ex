defmodule ParamountLandscaping.Factory do
  use ExMachina.Ecto, repo: ParamountLandscaping.Repo

  def job_factory do
    %ParamountLandscaping.Jobs.Job{
      name: sequence(:name, &"Job #{&1}"),
      address: sequence(:address, &"#{&1} Main Street"),
      description: sequence(:description, &"Description for job #{&1}"),
      line_items: [],
      labors: []
    }
  end

  def line_item_factory do
    %ParamountLandscaping.LineItems.LineItem{
      material: sequence(:material, &"Material #{&1}"),
      unit_cost: 42,
      quantity: Decimal.new("2.5"),
      total: Decimal.new("105.00"),
    }
  end

  def labor_factory do
    %ParamountLandscaping.Labors.Labor{
      worker: sequence(:worker, &"Worker #{&1}"),
      hours: Decimal.new("8.0"),
      per_hour_cost: 45,
    }
  end
end
