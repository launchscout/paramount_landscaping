defmodule ParamountLandscaping.SnowJobsTest do
  use ParamountLandscaping.DataCase

  alias ParamountLandscaping.SnowJobs

  describe "snow_jobs" do
    alias ParamountLandscaping.SnowJobs.SnowJob

    import ParamountLandscaping.SnowJobsFixtures

    @invalid_attrs %{date: nil}

    test "list_snow_jobs/0 returns all snow_jobs" do
      snow_job = snow_job_fixture()
      assert SnowJobs.list_snow_jobs() == [snow_job]
    end

    test "get_snow_job!/1 returns the snow_job with given id" do
      snow_job = snow_job_fixture()
      assert SnowJobs.get_snow_job!(snow_job.id) == snow_job
    end

    test "create_snow_job/1 with valid data creates a snow_job" do
      valid_attrs = %{date: ~D[2025-01-29]}

      assert {:ok, %SnowJob{} = snow_job} = SnowJobs.create_snow_job(valid_attrs)
      assert snow_job.date == ~D[2025-01-29]
    end

    test "create_snow_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SnowJobs.create_snow_job(@invalid_attrs)
    end

    test "update_snow_job/2 with valid data updates the snow_job" do
      snow_job = snow_job_fixture()
      update_attrs = %{date: ~D[2025-01-30]}

      assert {:ok, %SnowJob{} = snow_job} = SnowJobs.update_snow_job(snow_job, update_attrs)
      assert snow_job.date == ~D[2025-01-30]
    end

    test "update_snow_job/2 with invalid data returns error changeset" do
      snow_job = snow_job_fixture()
      assert {:error, %Ecto.Changeset{}} = SnowJobs.update_snow_job(snow_job, @invalid_attrs)
      assert snow_job == SnowJobs.get_snow_job!(snow_job.id)
    end

    test "delete_snow_job/1 deletes the snow_job" do
      snow_job = snow_job_fixture()
      assert {:ok, %SnowJob{}} = SnowJobs.delete_snow_job(snow_job)
      assert_raise Ecto.NoResultsError, fn -> SnowJobs.get_snow_job!(snow_job.id) end
    end

    test "change_snow_job/1 returns a snow_job changeset" do
      snow_job = snow_job_fixture()
      assert %Ecto.Changeset{} = SnowJobs.change_snow_job(snow_job)
    end
  end
end
