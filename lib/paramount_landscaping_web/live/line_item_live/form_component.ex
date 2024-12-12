defmodule ParamountLandscapingWeb.LineItemLive.FormComponent do
  use ParamountLandscapingWeb, :live_component

  alias ParamountLandscaping.LineItems

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage line_item records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="line_item-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:material]} type="text" label="Material" />
        <.input field={@form[:unit_cost]} type="number" label="Unit cost" />
        <.input field={@form[:quantity]} type="number" label="Quantity" step="any" />
        <.input field={@form[:total]} type="number" label="Total" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Line item</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{line_item: line_item} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(LineItems.change_line_item(line_item))
     end)}
  end

  @impl true
  def handle_event("validate", %{"line_item" => line_item_params}, socket) do
    changeset = LineItems.change_line_item(socket.assigns.line_item, line_item_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"line_item" => line_item_params}, socket) do
    save_line_item(socket, socket.assigns.action, line_item_params)
  end

  defp save_line_item(socket, :edit, line_item_params) do
    case LineItems.update_line_item(socket.assigns.line_item, line_item_params) do
      {:ok, line_item} ->
        notify_parent({:saved, line_item})

        {:noreply,
         socket
         |> put_flash(:info, "Line item updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_line_item(socket, :new, line_item_params) do
    case LineItems.create_line_item(line_item_params) do
      {:ok, line_item} ->
        notify_parent({:saved, line_item})

        {:noreply,
         socket
         |> put_flash(:info, "Line item created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
