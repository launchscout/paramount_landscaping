defmodule ParamountLandscapingWeb.JobLive.Show do
  use ParamountLandscapingWeb, :live_view

  alias ParamountLandscaping.Jobs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:job, Jobs.get_job!(id, preload: [:line_items, :labors]))}
  end

  defp page_title(:show), do: "Show Job"
  defp page_title(:edit), do: "Edit Job"
end
