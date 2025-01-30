defmodule ParamountLandscaping.Repo.Migrations.CreateRoutes do
  use Ecto.Migration

  def change do
    create table(:routes) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
