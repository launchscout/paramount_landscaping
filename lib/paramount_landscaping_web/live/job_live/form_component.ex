defmodule ParamountLandscapingWeb.JobLive.FormComponent do
  use ParamountLandscapingWeb, :live_component

  alias ParamountLandscaping.Jobs
  alias ParamountLandscaping.Jobs.Job

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage job records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="job-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:description]} type="text" label="Description" />

        <div class="mt-8">
          <h3 class="text-lg font-semibold">Line Items</h3>
          <div class="mt-4 space-y-4" id="line-items">
            <.inputs_for :let={f_item} field={@form[:line_items]}>
              <div class="flex items-end gap-4">
                <.input field={f_item[:material]} type="text" label="Material" />
                <.input field={f_item[:unit_cost]} type="number" label="Unit Cost" />
                <.input field={f_item[:quantity]} type="number" label="Quantity" step="any" />
                <input type="hidden" name="job[line_items_order][]" value={f_item.index} />
                <div class="mb-6">
                  <button
                    type="button"
                    class="text-red-600"
                    phx-click="remove_line_item"
                    phx-value-index={f_item.index}
                    phx-target={@myself}
                  >
                    Remove
                  </button>
                </div>
              </div>
            </.inputs_for>
          </div>
          <label class="block cursor-pointer u-color-primary">
            <input type="checkbox" name="job[line_items_order][]" class="hidden" />
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
              <span>Add Line Item</span>
            </span>
          </label>
        </div>

        <div class="mt-8">
          <h3 class="text-lg font-semibold">Labor Entries</h3>
          <div class="mt-4 space-y-4" id="labors">
            <.inputs_for :let={f_labor} field={@form[:labors]}>
              <div class="flex items-end gap-4">
                <.input field={f_labor[:worker]} type="text" label="Worker" />
                <.input field={f_labor[:hours]} type="number" label="Hours" step="any" />
                <.input field={f_labor[:per_hour_cost]} type="number" label="Per Hour Cost" />
                <input type="hidden" name="job[labor_order][]" value={f_labor.index} />
                <div class="mb-6">
                  <button
                    type="button"
                    class="text-red-600"
                    phx-click="remove_labor"
                    phx-value-index={f_labor.index}
                    phx-target={@myself}
                  >
                    Remove
                  </button>
                </div>
              </div>
            </.inputs_for>
          </div>
          <label class="block cursor-pointer u-color-primary">
            <input type="checkbox" name="job[labor_order][]" class="hidden" />
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
              <span>Add Labor</span>
            </span>
          </label>
        </div>

        <:actions>
          <.button phx-disable-with="Saving...">Save Job</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{job: job} = assigns, socket) do
    changeset = Jobs.change_job(job)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:form, to_form(changeset))}
  end

  @impl true
  def handle_event("validate", %{"job" => job_params}, socket) do
    changeset =
      socket.assigns.job
      |> Jobs.change_job(job_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("add_line_item", _, socket) do
    changeset =
      socket.assigns.form.data
      |> Jobs.change_job(socket.assigns.form.params || %{})
      |> Ecto.Changeset.put_assoc(:line_items, [
        %ParamountLandscaping.LineItems.LineItem{} | socket.assigns.form.data.line_items || []
      ])

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("remove_line_item", %{"index" => index}, socket) do
    params = socket.assigns.form.params || %{}
    index = String.to_integer(index)

    line_items_params = Map.get(params, "line_items", %{})
    updated_params = put_in(params, ["line_items", to_string(index), "delete"], "true")

    changeset =
      socket.assigns.job
      |> Jobs.change_job(updated_params)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("add_labor", _, socket) do
    changeset =
      socket.assigns.form.data
      |> Jobs.change_job(socket.assigns.form.params || %{})
      |> Ecto.Changeset.put_assoc(:labors, [
        %ParamountLandscaping.Labors.Labor{} | socket.assigns.form.data.labors || []
      ])

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("remove_labor", %{"index" => index}, socket) do
    params = socket.assigns.form.params || %{}
    index = String.to_integer(index)

    updated_params = put_in(params, ["labors", to_string(index), "delete"], "true")

    changeset =
      socket.assigns.job
      |> Jobs.change_job(updated_params)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("save", %{"job" => job_params}, socket) do
    save_job(socket, socket.assigns.action, job_params)
  end

  defp save_job(socket, :edit, job_params) do
    case Jobs.update_job(socket.assigns.job, job_params) do
      {:ok, job} ->
        notify_parent({:saved, job})

        {:noreply,
         socket
         |> put_flash(:info, "Job updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_job(socket, :new, job_params) do
    case Jobs.create_job(job_params) do
      {:ok, job} ->
        notify_parent({:saved, job})

        {:noreply,
         socket
         |> put_flash(:info, "Job created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
