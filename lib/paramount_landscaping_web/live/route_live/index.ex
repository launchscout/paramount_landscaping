defmodule ParamountLandscapingWeb.RouteLive.Index do
  use ParamountLandscapingWeb, :live_view

  alias ParamountLandscaping.Routes
  alias ParamountLandscaping.Routes.Route

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :routes, Routes.list_routes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Route")
    |> assign(:route, Routes.get_route!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Route")
    |> assign(:route, %Route{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Routes")
    |> assign(:route, nil)
  end

  @impl true
  def handle_info({ParamountLandscapingWeb.RouteLive.FormComponent, {:saved, route}}, socket) do
    {:noreply, stream_insert(socket, :routes, route)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    route = Routes.get_route!(id)
    {:ok, _} = Routes.delete_route(route)

    {:noreply, stream_delete(socket, :routes, route)}
  end
end
