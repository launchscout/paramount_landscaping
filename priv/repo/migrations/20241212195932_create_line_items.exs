defmodule ParamountLandscaping.Repo.Migrations.CreateLineItems do
  use Ecto.Migration

  def change do
    create table(:line_items) do
      add :material, :string
      add :unit_cost, :integer
      add :quantity, :decimal
      add :total, :integer
      add :job_id, references(:jobs, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:line_items, [:job_id])
  end
end
