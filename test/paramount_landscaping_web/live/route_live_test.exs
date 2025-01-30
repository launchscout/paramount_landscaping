defmodule ParamountLandscapingWeb.RouteLiveTest do
  use ParamountLandscapingWeb.ConnCase

  import Phoenix.LiveViewTest
  import ParamountLandscaping.RoutesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_route(_) do
    route = route_fixture()
    %{route: route}
  end

  describe "Index" do
    setup [:create_route]

    test "lists all routes", %{conn: conn, route: route} do
      {:ok, _index_live, html} = live(conn, ~p"/routes")

      assert html =~ "Listing Routes"
      assert html =~ route.name
    end

    test "saves new route", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/routes")

      assert index_live |> element("a", "New Route") |> render_click() =~
               "New Route"

      assert_patch(index_live, ~p"/routes/new")

      assert index_live
             |> form("#route-form", route: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#route-form", route: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/routes")

      html = render(index_live)
      assert html =~ "Route created successfully"
      assert html =~ "some name"
    end

    test "updates route in listing", %{conn: conn, route: route} do
      {:ok, index_live, _html} = live(conn, ~p"/routes")

      assert index_live |> element("#routes-#{route.id} a", "Edit") |> render_click() =~
               "Edit Route"

      assert_patch(index_live, ~p"/routes/#{route}/edit")

      assert index_live
             |> form("#route-form", route: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#route-form", route: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/routes")

      html = render(index_live)
      assert html =~ "Route updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes route in listing", %{conn: conn, route: route} do
      {:ok, index_live, _html} = live(conn, ~p"/routes")

      assert index_live |> element("#routes-#{route.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#routes-#{route.id}")
    end
  end

  describe "Show" do
    setup [:create_route]

    test "displays route", %{conn: conn, route: route} do
      {:ok, _show_live, html} = live(conn, ~p"/routes/#{route}")

      assert html =~ "Show Route"
      assert html =~ route.name
    end

    test "updates route within modal", %{conn: conn, route: route} do
      {:ok, show_live, _html} = live(conn, ~p"/routes/#{route}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Route"

      assert_patch(show_live, ~p"/routes/#{route}/show/edit")

      assert show_live
             |> form("#route-form", route: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#route-form", route: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/routes/#{route}")

      html = render(show_live)
      assert html =~ "Route updated successfully"
      assert html =~ "some updated name"
    end
  end
end
