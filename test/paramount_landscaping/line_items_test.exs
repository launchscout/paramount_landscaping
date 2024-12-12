defmodule ParamountLandscaping.LineItemsTest do
  use ParamountLandscaping.DataCase

  alias ParamountLandscaping.LineItems

  describe "line_items" do
    alias ParamountLandscaping.LineItems.LineItem

    import ParamountLandscaping.LineItemsFixtures

    @invalid_attrs %{total: nil, material: nil, unit_cost: nil, quantity: nil}

    test "list_line_items/0 returns all line_items" do
      line_item = line_item_fixture()
      assert LineItems.list_line_items() == [line_item]
    end

    test "get_line_item!/1 returns the line_item with given id" do
      line_item = line_item_fixture()
      assert LineItems.get_line_item!(line_item.id) == line_item
    end

    test "create_line_item/1 with valid data creates a line_item" do
      valid_attrs = %{total: 42, material: "some material", unit_cost: 42, quantity: "120.5"}

      assert {:ok, %LineItem{} = line_item} = LineItems.create_line_item(valid_attrs)
      assert line_item.total == 42
      assert line_item.material == "some material"
      assert line_item.unit_cost == 42
      assert line_item.quantity == Decimal.new("120.5")
    end

    test "create_line_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LineItems.create_line_item(@invalid_attrs)
    end

    test "update_line_item/2 with valid data updates the line_item" do
      line_item = line_item_fixture()
      update_attrs = %{total: 43, material: "some updated material", unit_cost: 43, quantity: "456.7"}

      assert {:ok, %LineItem{} = line_item} = LineItems.update_line_item(line_item, update_attrs)
      assert line_item.total == 43
      assert line_item.material == "some updated material"
      assert line_item.unit_cost == 43
      assert line_item.quantity == Decimal.new("456.7")
    end

    test "update_line_item/2 with invalid data returns error changeset" do
      line_item = line_item_fixture()
      assert {:error, %Ecto.Changeset{}} = LineItems.update_line_item(line_item, @invalid_attrs)
      assert line_item == LineItems.get_line_item!(line_item.id)
    end

    test "delete_line_item/1 deletes the line_item" do
      line_item = line_item_fixture()
      assert {:ok, %LineItem{}} = LineItems.delete_line_item(line_item)
      assert_raise Ecto.NoResultsError, fn -> LineItems.get_line_item!(line_item.id) end
    end

    test "change_line_item/1 returns a line_item changeset" do
      line_item = line_item_fixture()
      assert %Ecto.Changeset{} = LineItems.change_line_item(line_item)
    end
  end
end
