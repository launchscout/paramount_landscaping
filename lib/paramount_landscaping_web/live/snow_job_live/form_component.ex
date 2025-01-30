defmodule ParamountLandscapingWeb.SnowJobLive.FormComponent do
  use ParamountLandscapingWeb, :live_component

  alias ParamountLandscaping.SnowJobs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage snow_job records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="snow_job-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:date]} type="date" label="Date" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Snow job</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{snow_job: snow_job} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(SnowJobs.change_snow_job(snow_job))
     end)}
  end

  @impl true
  def handle_event("validate", %{"snow_job" => snow_job_params}, socket) do
    changeset = SnowJobs.change_snow_job(socket.assigns.snow_job, snow_job_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"snow_job" => snow_job_params}, socket) do
    save_snow_job(socket, socket.assigns.action, snow_job_params)
  end

  defp save_snow_job(socket, :edit, snow_job_params) do
    case SnowJobs.update_snow_job(socket.assigns.snow_job, snow_job_params) do
      {:ok, snow_job} ->
        notify_parent({:saved, snow_job})

        {:noreply,
         socket
         |> put_flash(:info, "Snow job updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_snow_job(socket, :new, snow_job_params) do
    case SnowJobs.create_snow_job(snow_job_params) do
      {:ok, snow_job} ->
        notify_parent({:saved, snow_job})

        {:noreply,
         socket
         |> put_flash(:info, "Snow job created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
