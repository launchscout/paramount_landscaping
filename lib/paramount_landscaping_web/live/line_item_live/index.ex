defmodule ParamountLandscapingWeb.LineItemLive.Index do
  use ParamountLandscapingWeb, :live_view

  alias ParamountLandscaping.LineItems
  alias ParamountLandscaping.LineItems.LineItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :line_items, LineItems.list_line_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Line item")
    |> assign(:line_item, LineItems.get_line_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Line item")
    |> assign(:line_item, %LineItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Line items")
    |> assign(:line_item, nil)
  end

  @impl true
  def handle_info({ParamountLandscapingWeb.LineItemLive.FormComponent, {:saved, line_item}}, socket) do
    {:noreply, stream_insert(socket, :line_items, line_item)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    line_item = LineItems.get_line_item!(id)
    {:ok, _} = LineItems.delete_line_item(line_item)

    {:noreply, stream_delete(socket, :line_items, line_item)}
  end
end
