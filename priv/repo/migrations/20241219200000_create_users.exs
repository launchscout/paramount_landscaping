defmodule ParamountLandscaping.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :provider, :string, null: false
      add :token, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
