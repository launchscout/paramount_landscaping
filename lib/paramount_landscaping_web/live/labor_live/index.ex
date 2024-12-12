defmodule ParamountLandscapingWeb.LaborLive.Index do
  use ParamountLandscapingWeb, :live_view

  alias ParamountLandscaping.Labors
  alias ParamountLandscaping.Labors.Labor

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :labors, Labors.list_labors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Labor")
    |> assign(:labor, Labors.get_labor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Labor")
    |> assign(:labor, %Labor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Labors")
    |> assign(:labor, nil)
  end

  @impl true
  def handle_info({ParamountLandscapingWeb.LaborLive.FormComponent, {:saved, labor}}, socket) do
    {:noreply, stream_insert(socket, :labors, labor)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    labor = Labors.get_labor!(id)
    {:ok, _} = Labors.delete_labor(labor)

    {:noreply, stream_delete(socket, :labors, labor)}
  end
end
