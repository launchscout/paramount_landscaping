defmodule ParamountLandscapingWeb.SnowJobLiveTest do
  use ParamountLandscapingWeb.ConnCase

  import Phoenix.LiveViewTest
  import ParamountLandscaping.SnowJobsFixtures

  @create_attrs %{date: "2025-01-29"}
  @update_attrs %{date: "2025-01-30"}
  @invalid_attrs %{date: nil}

  defp create_snow_job(_) do
    snow_job = snow_job_fixture()
    %{snow_job: snow_job}
  end

  describe "Index" do
    setup [:create_snow_job]

    test "lists all snow_jobs", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/snow_jobs")

      assert html =~ "Listing Snow jobs"
    end

    test "saves new snow_job", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/snow_jobs")

      assert index_live |> element("a", "New Snow job") |> render_click() =~
               "New Snow job"

      assert_patch(index_live, ~p"/snow_jobs/new")

      assert index_live
             |> form("#snow_job-form", snow_job: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#snow_job-form", snow_job: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/snow_jobs")

      html = render(index_live)
      assert html =~ "Snow job created successfully"
    end

    test "updates snow_job in listing", %{conn: conn, snow_job: snow_job} do
      {:ok, index_live, _html} = live(conn, ~p"/snow_jobs")

      assert index_live |> element("#snow_jobs-#{snow_job.id} a", "Edit") |> render_click() =~
               "Edit Snow job"

      assert_patch(index_live, ~p"/snow_jobs/#{snow_job}/edit")

      assert index_live
             |> form("#snow_job-form", snow_job: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#snow_job-form", snow_job: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/snow_jobs")

      html = render(index_live)
      assert html =~ "Snow job updated successfully"
    end

    test "deletes snow_job in listing", %{conn: conn, snow_job: snow_job} do
      {:ok, index_live, _html} = live(conn, ~p"/snow_jobs")

      assert index_live |> element("#snow_jobs-#{snow_job.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#snow_jobs-#{snow_job.id}")
    end
  end

  describe "Show" do
    setup [:create_snow_job]

    test "displays snow_job", %{conn: conn, snow_job: snow_job} do
      {:ok, _show_live, html} = live(conn, ~p"/snow_jobs/#{snow_job}")

      assert html =~ "Show Snow job"
    end

    test "updates snow_job within modal", %{conn: conn, snow_job: snow_job} do
      {:ok, show_live, _html} = live(conn, ~p"/snow_jobs/#{snow_job}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Snow job"

      assert_patch(show_live, ~p"/snow_jobs/#{snow_job}/show/edit")

      assert show_live
             |> form("#snow_job-form", snow_job: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#snow_job-form", snow_job: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/snow_jobs/#{snow_job}")

      html = render(show_live)
      assert html =~ "Snow job updated successfully"
    end
  end
end
