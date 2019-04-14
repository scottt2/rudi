defmodule Rudi.InsightsTest do
  use Rudi.DataCase

  alias Rudi.Insights

  describe "progress_reports" do
    alias Rudi.Insights.ProgressReport

    @valid_attrs %{addition_average: 120.5, addition_count: 42, deletion_average: 120.5, deletion_count: 42, delta_max_avg: 120.5, delta_min_avg: 120.5, public: true, public_id: "7488a646-e31f-11e4-aace-600308960662", week: 42, year: 42}
    @update_attrs %{addition_average: 456.7, addition_count: 43, deletion_average: 456.7, deletion_count: 43, delta_max_avg: 456.7, delta_min_avg: 456.7, public: false, public_id: "7488a646-e31f-11e4-aace-600308960668", week: 43, year: 43}
    @invalid_attrs %{addition_average: nil, addition_count: nil, deletion_average: nil, deletion_count: nil, delta_max_avg: nil, delta_min_avg: nil, public: nil, public_id: nil, week: nil, year: nil}

    def progress_report_fixture(attrs \\ %{}) do
      {:ok, progress_report} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Insights.create_progress_report()

      progress_report
    end

    test "list_progress_reports/0 returns all progress_reports" do
      progress_report = progress_report_fixture()
      assert Insights.list_progress_reports() == [progress_report]
    end

    test "get_progress_report!/1 returns the progress_report with given id" do
      progress_report = progress_report_fixture()
      assert Insights.get_progress_report!(progress_report.id) == progress_report
    end

    test "create_progress_report/1 with valid data creates a progress_report" do
      assert {:ok, %ProgressReport{} = progress_report} = Insights.create_progress_report(@valid_attrs)
      assert progress_report.addition_average == 120.5
      assert progress_report.addition_count == 42
      assert progress_report.deletion_average == 120.5
      assert progress_report.deletion_count == 42
      assert progress_report.delta_max_avg == 120.5
      assert progress_report.delta_min_avg == 120.5
      assert progress_report.public == true
      assert progress_report.public_id == "7488a646-e31f-11e4-aace-600308960662"
      assert progress_report.week == 42
      assert progress_report.year == 42
    end

    test "create_progress_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Insights.create_progress_report(@invalid_attrs)
    end

    test "update_progress_report/2 with valid data updates the progress_report" do
      progress_report = progress_report_fixture()
      assert {:ok, %ProgressReport{} = progress_report} = Insights.update_progress_report(progress_report, @update_attrs)
      assert progress_report.addition_average == 456.7
      assert progress_report.addition_count == 43
      assert progress_report.deletion_average == 456.7
      assert progress_report.deletion_count == 43
      assert progress_report.delta_max_avg == 456.7
      assert progress_report.delta_min_avg == 456.7
      assert progress_report.public == false
      assert progress_report.public_id == "7488a646-e31f-11e4-aace-600308960668"
      assert progress_report.week == 43
      assert progress_report.year == 43
    end

    test "update_progress_report/2 with invalid data returns error changeset" do
      progress_report = progress_report_fixture()
      assert {:error, %Ecto.Changeset{}} = Insights.update_progress_report(progress_report, @invalid_attrs)
      assert progress_report == Insights.get_progress_report!(progress_report.id)
    end

    test "delete_progress_report/1 deletes the progress_report" do
      progress_report = progress_report_fixture()
      assert {:ok, %ProgressReport{}} = Insights.delete_progress_report(progress_report)
      assert_raise Ecto.NoResultsError, fn -> Insights.get_progress_report!(progress_report.id) end
    end

    test "change_progress_report/1 returns a progress_report changeset" do
      progress_report = progress_report_fixture()
      assert %Ecto.Changeset{} = Insights.change_progress_report(progress_report)
    end
  end
end
