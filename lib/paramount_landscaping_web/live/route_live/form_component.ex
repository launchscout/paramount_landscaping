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

        <div class="mt-8">
          <h3 class="text-lg font-semibold">Stops</h3>
          <div class="mt-4 space-y-4" id="stops">
            <.inputs_for :let={f_stop} field={@form[:stops]}>
              <div class="grid grid-cols-12 gap-4 items-end">
                <div class="col-span-4">
                  <.input field={f_stop[:name]} type="text" label="Name" />
                </div>
                <div class="col-span-5">
                  <.input field={f_stop[:address]} type="text" label="Address" />
                </div>
                <div class="col-span-2">
                  <.input field={f_stop[:walk]} type="checkbox" label="Walk" />
                </div>
                <input type="hidden" name="route[stops_order][]" value={f_stop.index} />
                <div class="col-span-1 justify-self-end">
                  <label class="icons block cursor-pointer">
                    <input type="checkbox" name="route[stops_delete][]" value={f_stop.index} class="hidden" />
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={1.5}
                      stroke="#4467D8"
                      class="size-6"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="m9.75 9.75 4.5 4.5m0-4.5-4.5 4.5M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                      />
                    </svg>
                  </label>
                </div>
              </div>
            </.inputs_for>
          </div>
          <label class="block cursor-pointer u-color-primary">
            <input type="checkbox" name="route[stops_order][]" class="hidden" />
              <span class="flex items-center gap-2">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={1.5}
                  stroke="#4467D8"
                  class="w-4 h-4"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                  />
                </svg>
                <span>Add Stop</span>
              </span>
          </label>
        </div>

        <:actions>
          <.button phx-disable-with="Saving...">Save Route</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{route: route} = assigns, socket) do
    changeset = Routes.change_route(route)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:form, to_form(changeset))}
  end

  @impl true
  def handle_event("validate", %{"route" => route_params}, socket) do
    changeset =
      socket.assigns.route
      |> Routes.change_route(route_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset))}
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
