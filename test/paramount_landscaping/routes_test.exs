defmodule ParamountLandscaping.RoutesTest do
  use ParamountLandscaping.DataCase

  alias ParamountLandscaping.Routes

  describe "routes" do
    alias ParamountLandscaping.Routes.Route

    import ParamountLandscaping.RoutesFixtures

    @invalid_attrs %{name: nil}

    test "list_routes/0 returns all routes" do
      route = route_fixture()
      assert Routes.list_routes() == [route]
    end

    test "get_route!/1 returns the route with given id" do
      route = route_fixture()
      assert Routes.get_route!(route.id) == route
    end

    test "create_route/1 with valid data creates a route" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Route{} = route} = Routes.create_route(valid_attrs)
      assert route.name == "some name"
    end

    test "create_route/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Routes.create_route(@invalid_attrs)
    end

    test "update_route/2 with valid data updates the route" do
      route = route_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Route{} = route} = Routes.update_route(route, update_attrs)
      assert route.name == "some updated name"
    end

    test "update_route/2 with invalid data returns error changeset" do
      route = route_fixture()
      assert {:error, %Ecto.Changeset{}} = Routes.update_route(route, @invalid_attrs)
      assert route == Routes.get_route!(route.id)
    end

    test "delete_route/1 deletes the route" do
      route = route_fixture()
      assert {:ok, %Route{}} = Routes.delete_route(route)
      assert_raise Ecto.NoResultsError, fn -> Routes.get_route!(route.id) end
    end

    test "change_route/1 returns a route changeset" do
      route = route_fixture()
      assert %Ecto.Changeset{} = Routes.change_route(route)
    end
  end

  describe "stops" do
    alias ParamountLandscaping.Routes.Stop

    import ParamountLandscaping.RoutesFixtures

    @invalid_attrs %{name: nil, address: nil, walk: nil}

    test "list_stops/0 returns all stops" do
      stop = stop_fixture()
      assert Routes.list_stops() == [stop]
    end

    test "get_stop!/1 returns the stop with given id" do
      stop = stop_fixture()
      assert Routes.get_stop!(stop.id) == stop
    end

    test "create_stop/1 with valid data creates a stop" do
      valid_attrs = %{name: "some name", address: "some address", walk: true}

      assert {:ok, %Stop{} = stop} = Routes.create_stop(valid_attrs)
      assert stop.name == "some name"
      assert stop.address == "some address"
      assert stop.walk == true
    end

    test "create_stop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Routes.create_stop(@invalid_attrs)
    end

    test "update_stop/2 with valid data updates the stop" do
      stop = stop_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", walk: false}

      assert {:ok, %Stop{} = stop} = Routes.update_stop(stop, update_attrs)
      assert stop.name == "some updated name"
      assert stop.address == "some updated address"
      assert stop.walk == false
    end

    test "update_stop/2 with invalid data returns error changeset" do
      stop = stop_fixture()
      assert {:error, %Ecto.Changeset{}} = Routes.update_stop(stop, @invalid_attrs)
      assert stop == Routes.get_stop!(stop.id)
    end

    test "delete_stop/1 deletes the stop" do
      stop = stop_fixture()
      assert {:ok, %Stop{}} = Routes.delete_stop(stop)
      assert_raise Ecto.NoResultsError, fn -> Routes.get_stop!(stop.id) end
    end

    test "change_stop/1 returns a stop changeset" do
      stop = stop_fixture()
      assert %Ecto.Changeset{} = Routes.change_stop(stop)
    end
  end
end
