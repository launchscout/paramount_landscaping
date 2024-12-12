defmodule ParamountLandscaping.LaborsTest do
  use ParamountLandscaping.DataCase

  alias ParamountLandscaping.Labors

  describe "labors" do
    alias ParamountLandscaping.Labors.Labor

    import ParamountLandscaping.LaborsFixtures

    @invalid_attrs %{worker: nil, hours: nil, per_hour_cost: nil}

    test "list_labors/0 returns all labors" do
      labor = labor_fixture()
      assert Labors.list_labors() == [labor]
    end

    test "get_labor!/1 returns the labor with given id" do
      labor = labor_fixture()
      assert Labors.get_labor!(labor.id) == labor
    end

    test "create_labor/1 with valid data creates a labor" do
      valid_attrs = %{worker: "some worker", hours: "120.5", per_hour_cost: 42}

      assert {:ok, %Labor{} = labor} = Labors.create_labor(valid_attrs)
      assert labor.worker == "some worker"
      assert labor.hours == Decimal.new("120.5")
      assert labor.per_hour_cost == 42
    end

    test "create_labor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Labors.create_labor(@invalid_attrs)
    end

    test "update_labor/2 with valid data updates the labor" do
      labor = labor_fixture()
      update_attrs = %{worker: "some updated worker", hours: "456.7", per_hour_cost: 43}

      assert {:ok, %Labor{} = labor} = Labors.update_labor(labor, update_attrs)
      assert labor.worker == "some updated worker"
      assert labor.hours == Decimal.new("456.7")
      assert labor.per_hour_cost == 43
    end

    test "update_labor/2 with invalid data returns error changeset" do
      labor = labor_fixture()
      assert {:error, %Ecto.Changeset{}} = Labors.update_labor(labor, @invalid_attrs)
      assert labor == Labors.get_labor!(labor.id)
    end

    test "delete_labor/1 deletes the labor" do
      labor = labor_fixture()
      assert {:ok, %Labor{}} = Labors.delete_labor(labor)
      assert_raise Ecto.NoResultsError, fn -> Labors.get_labor!(labor.id) end
    end

    test "change_labor/1 returns a labor changeset" do
      labor = labor_fixture()
      assert %Ecto.Changeset{} = Labors.change_labor(labor)
    end
  end
end
