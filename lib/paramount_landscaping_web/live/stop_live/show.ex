defmodule ParamountLandscapingWeb.StopLive.Show do
  use ParamountLandscapingWeb, :live_view

  alias ParamountLandscaping.Routes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:stop, Routes.get_stop!(id))}
  end

  defp page_title(:show), do: "Show Stop"
  defp page_title(:edit), do: "Edit Stop"
end
