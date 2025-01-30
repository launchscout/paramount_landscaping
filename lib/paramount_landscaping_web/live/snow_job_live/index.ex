defmodule ParamountLandscapingWeb.SnowJobLive.Index do
  use ParamountLandscapingWeb, :live_view

  alias ParamountLandscaping.SnowJobs
  alias ParamountLandscaping.SnowJobs.SnowJob

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :snow_jobs, SnowJobs.list_snow_jobs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Snow job")
    |> assign(:snow_job, SnowJobs.get_snow_job!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Snow job")
    |> assign(:snow_job, %SnowJob{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Snow jobs")
    |> assign(:snow_job, nil)
  end

  @impl true
  def handle_info({ParamountLandscapingWeb.SnowJobLive.FormComponent, {:saved, snow_job}}, socket) do
    {:noreply, stream_insert(socket, :snow_jobs, snow_job)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    snow_job = SnowJobs.get_snow_job!(id)
    {:ok, _} = SnowJobs.delete_snow_job(snow_job)

    {:noreply, stream_delete(socket, :snow_jobs, snow_job)}
  end
end
