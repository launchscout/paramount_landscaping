defmodule ParamountLandscapingWeb.StopLive.Index do
  use ParamountLandscapingWeb, :live_view

  alias ParamountLandscaping.Routes
  alias ParamountLandscaping.Routes.Stop

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :stops, Routes.list_stops())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Stop")
    |> assign(:stop, Routes.get_stop!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Stop")
    |> assign(:stop, %Stop{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stops")
    |> assign(:stop, nil)
  end

  @impl true
  def handle_info({ParamountLandscapingWeb.StopLive.FormComponent, {:saved, stop}}, socket) do
    {:noreply, stream_insert(socket, :stops, stop)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    stop = Routes.get_stop!(id)
    {:ok, _} = Routes.delete_stop(stop)

    {:noreply, stream_delete(socket, :stops, stop)}
  end
end
