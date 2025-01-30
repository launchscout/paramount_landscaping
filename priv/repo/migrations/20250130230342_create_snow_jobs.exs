defmodule ParamountLandscaping.Repo.Migrations.CreateSnowJobs do
  use Ecto.Migration

  def change do
    create table(:snow_jobs) do
      add :date, :date
      add :route_id, references(:routes, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:snow_jobs, [:route_id])
  end
end
