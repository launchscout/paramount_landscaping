defmodule ParamountLandscapingWeb.RouteLive.FormComponent do
  use ParamountLandscapingWeb, :live_component

  alias ParamountLandscaping.Routes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage route records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="route-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Route</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{route: route} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Routes.change_route(route))
     end)}
  end

  @impl true
  def handle_event("validate", %{"route" => route_params}, socket) do
    changeset = Routes.change_route(socket.assigns.route, route_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"route" => route_params}, socket) do
    save_route(socket, socket.assigns.action, route_params)
  end

  defp save_route(socket, :edit, route_params) do
    case Routes.update_route(socket.assigns.route, route_params) do
      {:ok, route} ->
        notify_parent({:saved, route})

        {:noreply,
         socket
         |> put_flash(:info, "Route updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_route(socket, :new, route_params) do
    case Routes.create_route(route_params) do
      {:ok, route} ->
        notify_parent({:saved, route})

        {:noreply,
         socket
         |> put_flash(:info, "Route created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
