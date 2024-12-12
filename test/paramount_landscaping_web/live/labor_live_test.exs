defmodule ParamountLandscapingWeb.LaborLiveTest do
  use ParamountLandscapingWeb.ConnCase

  import Phoenix.LiveViewTest
  import ParamountLandscaping.LaborsFixtures

  @create_attrs %{worker: "some worker", hours: "120.5", per_hour_cost: 42}
  @update_attrs %{worker: "some updated worker", hours: "456.7", per_hour_cost: 43}
  @invalid_attrs %{worker: nil, hours: nil, per_hour_cost: nil}

  defp create_labor(_) do
    labor = labor_fixture()
    %{labor: labor}
  end

  describe "Index" do
    setup [:create_labor]

    test "lists all labors", %{conn: conn, labor: labor} do
      {:ok, _index_live, html} = live(conn, ~p"/labors")

      assert html =~ "Listing Labors"
      assert html =~ labor.worker
    end

    test "saves new labor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/labors")

      assert index_live |> element("a", "New Labor") |> render_click() =~
               "New Labor"

      assert_patch(index_live, ~p"/labors/new")

      assert index_live
             |> form("#labor-form", labor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#labor-form", labor: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/labors")

      html = render(index_live)
      assert html =~ "Labor created successfully"
      assert html =~ "some worker"
    end

    test "updates labor in listing", %{conn: conn, labor: labor} do
      {:ok, index_live, _html} = live(conn, ~p"/labors")

      assert index_live |> element("#labors-#{labor.id} a", "Edit") |> render_click() =~
               "Edit Labor"

      assert_patch(index_live, ~p"/labors/#{labor}/edit")

      assert index_live
             |> form("#labor-form", labor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#labor-form", labor: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/labors")

      html = render(index_live)
      assert html =~ "Labor updated successfully"
      assert html =~ "some updated worker"
    end

    test "deletes labor in listing", %{conn: conn, labor: labor} do
      {:ok, index_live, _html} = live(conn, ~p"/labors")

      assert index_live |> element("#labors-#{labor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#labors-#{labor.id}")
    end
  end

  describe "Show" do
    setup [:create_labor]

    test "displays labor", %{conn: conn, labor: labor} do
      {:ok, _show_live, html} = live(conn, ~p"/labors/#{labor}")

      assert html =~ "Show Labor"
      assert html =~ labor.worker
    end

    test "updates labor within modal", %{conn: conn, labor: labor} do
      {:ok, show_live, _html} = live(conn, ~p"/labors/#{labor}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Labor"

      assert_patch(show_live, ~p"/labors/#{labor}/show/edit")

      assert show_live
             |> form("#labor-form", labor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#labor-form", labor: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/labors/#{labor}")

      html = render(show_live)
      assert html =~ "Labor updated successfully"
      assert html =~ "some updated worker"
    end
  end
end
