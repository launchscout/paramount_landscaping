defmodule ParamountLandscaping.Repo.Migrations.CreateLabors do
  use Ecto.Migration

  def change do
    create table(:labors) do
      add :worker, :string
      add :hours, :decimal
      add :per_hour_cost, :integer
      add :job_id, references(:jobs, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:labors, [:job_id])
  end
end
