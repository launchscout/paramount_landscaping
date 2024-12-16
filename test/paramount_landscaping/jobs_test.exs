defmodule ParamountLandscaping.JobsTest do
  use ParamountLandscaping.DataCase
  import ParamountLandscaping.Factory

  alias ParamountLandscaping.Jobs
  alias ParamountLandscaping.Jobs.Job

  describe "jobs" do
    @invalid_attrs %{name: nil, address: nil, description: nil}

    test "list_jobs/0 returns all jobs" do
      job = insert(:job)
      assert Jobs.list_jobs(preload: [:labors, :line_items]) == [job]
    end

    test "get_job!/1 returns the job with given id" do
      job = insert(:job)
      assert Jobs.get_job!(job.id, preload: [:labors, :line_items]) == job
    end

    test "create_job/1 with valid data creates a job" do
      attrs = params_for(:job)

      assert {:ok, %Job{} = job} = Jobs.create_job(attrs)
      assert job.name == attrs.name
      assert job.address == attrs.address
      assert job.description == attrs.description
    end

    test "create_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_job(@invalid_attrs)
    end

    test "update_job/2 with valid data updates the job" do
      job = insert(:job)
      update_attrs = params_for(:job)

      assert {:ok, %Job{} = updated_job} = Jobs.update_job(job, update_attrs)
      assert updated_job.name == update_attrs.name
      assert updated_job.address == update_attrs.address
      assert updated_job.description == update_attrs.description
    end

    test "update_job/2 with invalid data returns error changeset" do
      job = insert(:job)
      assert {:error, %Ecto.Changeset{}} = Jobs.update_job(job, @invalid_attrs)
      assert job == Jobs.get_job!(job.id, preload: [:labors, :line_items])
    end

    test "delete_job/1 deletes the job" do
      job = insert(:job)
      assert {:ok, %Job{}} = Jobs.delete_job(job)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_job!(job.id) end
    end

    test "change_job/1 returns a job changeset" do
      job = insert(:job)
      assert %Ecto.Changeset{} = Jobs.change_job(job)
    end

    test "calculate_materials_total/1 returns correct total" do
      job = insert(:job, line_items: [
        build(:line_item,
          quantity: Decimal.new("2"),
          unit_cost: 25,
          total: Decimal.new("50.00")
        ),
        build(:line_item,
          quantity: Decimal.new("5"),
          unit_cost: 12,
          total: Decimal.new("60.00")
        )
      ])

      assert Jobs.calculate_materials_total(job) == Decimal.new("110.00")
    end

    test "calculate_labor_total/1 returns correct total" do
      job = insert(:job, labors: [
        build(:labor,
          hours: Decimal.new("4.5"),
          per_hour_cost: 45
        ),
        build(:labor,
          hours: Decimal.new("3.0"),
          per_hour_cost: 45
        )
      ])

      assert Jobs.calculate_labor_total(job) == Decimal.new("337.50")
    end

    test "calculate_job_total/1 returns sum of line_items and labor" do
      job = insert(:job,
        line_items: [
          build(:line_item,
            quantity: Decimal.new("2"),
            unit_cost: 25,
            total: Decimal.new("50.00")
          )
        ],
        labors: [
          build(:labor,
            hours: Decimal.new("4.5"),
            per_hour_cost: 45
          )
        ]
      )

      assert Jobs.calculate_job_total(job) == Decimal.new("252.50")  # 50.00 + 202.50
    end

    test "retail_labor_total/1 returns total hours times 75" do
      job = insert(:job, labors: [
        build(:labor,
          hours: Decimal.new("4.5")
        ),
        build(:labor,
          hours: Decimal.new("3.0")
        )
      ])

      # 7.5 total hours * 75 = 562.50
      assert Jobs.retail_labor_total(job) == Decimal.new("562.50")
    end

    test "retail_materials_total/1 returns materials total times 1.5" do
      job = insert(:job, line_items: [
        build(:line_item,
          quantity: Decimal.new("2"),
          unit_cost: 25,
          total: Decimal.new("50.00")
        ),
        build(:line_item,
          quantity: Decimal.new("5"),
          unit_cost: 12,
          total: Decimal.new("60.00")
        )
      ])

      # (50.00 + 60.00) * 1.5 = 165.00
      assert Jobs.retail_materials_total(job) == Decimal.new("165.00")
    end

    test "retail_total/1 returns sum of retail_labor_total and retail_materials_total" do
      job = insert(:job,
        line_items: [
          build(:line_item,
            quantity: Decimal.new("2"),
            unit_cost: 25,
            total: Decimal.new("50.00")
          )
        ],
        labors: [
          build(:labor,
            hours: Decimal.new("4.5")
          )
        ]
      )

      # retail_labor_total: 4.5 hours * 75 = 337.50
      # retail_materials_total: 50.00 * 1.5 = 75.00
      # total: 337.50 + 75.00 = 412.50
      assert Jobs.retail_total(job) == Decimal.new("412.50")
    end
  end
end
