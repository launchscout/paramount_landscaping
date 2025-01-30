defmodule ParamountLandscaping.SnowJobs.SnowJob do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snow_jobs" do
    field :date, :date
    field :route_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(snow_job, attrs) do
    snow_job
    |> cast(attrs, [:date])
    |> validate_required([:date])
  end
end
