defmodule ParamountLandscapingWeb.StopLive.FormComponent do
  use ParamountLandscapingWeb, :live_component

  alias ParamountLandscaping.Routes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage stop records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="stop-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:walk]} type="checkbox" label="Walk" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Stop</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{stop: stop} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Routes.change_stop(stop))
     end)}
  end

  @impl true
  def handle_event("validate", %{"stop" => stop_params}, socket) do
    changeset = Routes.change_stop(socket.assigns.stop, stop_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"stop" => stop_params}, socket) do
    save_stop(socket, socket.assigns.action, stop_params)
  end

  defp save_stop(socket, :edit, stop_params) do
    case Routes.update_stop(socket.assigns.stop, stop_params) do
      {:ok, stop} ->
        notify_parent({:saved, stop})

        {:noreply,
         socket
         |> put_flash(:info, "Stop updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_stop(socket, :new, stop_params) do
    case Routes.create_stop(stop_params) do
      {:ok, stop} ->
        notify_parent({:saved, stop})

        {:noreply,
         socket
         |> put_flash(:info, "Stop created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
