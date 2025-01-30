defmodule ParamountLandscaping.Repo.Migrations.AddCapacityToStops do
  use Ecto.Migration

  def change do
    alter table(:stops) do
      add :capacity, :integer
    end
  end
end
