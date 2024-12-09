defmodule ParamountLandscaping.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :address, :string
      add :name, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
