defmodule ParamountLandscapingWeb.LineItemLiveTest do
  use ParamountLandscapingWeb.ConnCase

  import Phoenix.LiveViewTest
  import ParamountLandscaping.LineItemsFixtures

  @create_attrs %{total: 42, material: "some material", unit_cost: 42, quantity: "120.5"}
  @update_attrs %{total: 43, material: "some updated material", unit_cost: 43, quantity: "456.7"}
  @invalid_attrs %{total: nil, material: nil, unit_cost: nil, quantity: nil}

  defp create_line_item(_) do
    line_item = line_item_fixture()
    %{line_item: line_item}
  end

  describe "Index" do
    setup [:create_line_item]

    test "lists all line_items", %{conn: conn, line_item: line_item} do
      {:ok, _index_live, html} = live(conn, ~p"/line_items")

      assert html =~ "Listing Line items"
      assert html =~ line_item.material
    end

    test "saves new line_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/line_items")

      assert index_live |> element("a", "New Line item") |> render_click() =~
               "New Line item"

      assert_patch(index_live, ~p"/line_items/new")

      assert index_live
             |> form("#line_item-form", line_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#line_item-form", line_item: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/line_items")

      html = render(index_live)
      assert html =~ "Line item created successfully"
      assert html =~ "some material"
    end

    test "updates line_item in listing", %{conn: conn, line_item: line_item} do
      {:ok, index_live, _html} = live(conn, ~p"/line_items")

      assert index_live |> element("#line_items-#{line_item.id} a", "Edit") |> render_click() =~
               "Edit Line item"

      assert_patch(index_live, ~p"/line_items/#{line_item}/edit")

      assert index_live
             |> form("#line_item-form", line_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#line_item-form", line_item: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/line_items")

      html = render(index_live)
      assert html =~ "Line item updated successfully"
      assert html =~ "some updated material"
    end

    test "deletes line_item in listing", %{conn: conn, line_item: line_item} do
      {:ok, index_live, _html} = live(conn, ~p"/line_items")

      assert index_live |> element("#line_items-#{line_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#line_items-#{line_item.id}")
    end
  end

  describe "Show" do
    setup [:create_line_item]

    test "displays line_item", %{conn: conn, line_item: line_item} do
      {:ok, _show_live, html} = live(conn, ~p"/line_items/#{line_item}")

      assert html =~ "Show Line item"
      assert html =~ line_item.material
    end

    test "updates line_item within modal", %{conn: conn, line_item: line_item} do
      {:ok, show_live, _html} = live(conn, ~p"/line_items/#{line_item}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Line item"

      assert_patch(show_live, ~p"/line_items/#{line_item}/show/edit")

      assert show_live
             |> form("#line_item-form", line_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#line_item-form", line_item: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/line_items/#{line_item}")

      html = render(show_live)
      assert html =~ "Line item updated successfully"
      assert html =~ "some updated material"
    end
  end
end
