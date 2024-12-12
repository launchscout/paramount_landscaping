defmodule ParamountLandscapingWeb.LaborLive.FormComponent do
  use ParamountLandscapingWeb, :live_component

  alias ParamountLandscaping.Labors

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage labor records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="labor-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:worker]} type="text" label="Worker" />
        <.input field={@form[:hours]} type="number" label="Hours" step="any" />
        <.input field={@form[:per_hour_cost]} type="number" label="Per hour cost" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Labor</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{labor: labor} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Labors.change_labor(labor))
     end)}
  end

  @impl true
  def handle_event("validate", %{"labor" => labor_params}, socket) do
    changeset = Labors.change_labor(socket.assigns.labor, labor_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"labor" => labor_params}, socket) do
    save_labor(socket, socket.assigns.action, labor_params)
  end

  defp save_labor(socket, :edit, labor_params) do
    case Labors.update_labor(socket.assigns.labor, labor_params) do
      {:ok, labor} ->
        notify_parent({:saved, labor})

        {:noreply,
         socket
         |> put_flash(:info, "Labor updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_labor(socket, :new, labor_params) do
    case Labors.create_labor(labor_params) do
      {:ok, labor} ->
        notify_parent({:saved, labor})

        {:noreply,
         socket
         |> put_flash(:info, "Labor created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
