defmodule ParamountLandscapingWeb.LineItemLive.Show do
  use ParamountLandscapingWeb, :live_view

  alias ParamountLandscaping.LineItems

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:line_item, LineItems.get_line_item!(id))}
  end

  defp page_title(:show), do: "Show Line item"
  defp page_title(:edit), do: "Edit Line item"
end
