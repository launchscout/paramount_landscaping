defmodule ParamountLandscapingWeb.LaborLive.Show do
  use ParamountLandscapingWeb, :live_view

  alias ParamountLandscaping.Labors

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:labor, Labors.get_labor!(id))}
  end

  defp page_title(:show), do: "Show Labor"
  defp page_title(:edit), do: "Edit Labor"
end
