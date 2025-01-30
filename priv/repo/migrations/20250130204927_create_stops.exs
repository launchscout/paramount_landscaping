defmodule ParamountLandscaping.Repo.Migrations.CreateStops do
  use Ecto.Migration

  def change do
    create table(:stops) do
      add :name, :string
      add :address, :string
      add :walk, :boolean, default: false, null: false
      add :route_id, references(:routes, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:stops, [:route_id])
  end
end
