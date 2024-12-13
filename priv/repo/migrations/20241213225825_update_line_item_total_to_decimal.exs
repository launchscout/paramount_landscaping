defmodule ParamountLandscaping.Repo.Migrations.UpdateLineItemTotalToDecimal do
  use Ecto.Migration

  def change do
    alter table(:line_items) do
      modify :total, :decimal, precision: 10, scale: 2
    end
  end
end
