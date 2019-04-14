defmodule RudiWeb.ProgressReportControllerTest do
  use RudiWeb.ConnCase

  alias Rudi.Insights

  @create_attrs %{addition_average: 120.5, addition_count: 42, deletion_average: 120.5, deletion_count: 42, delta_max_avg: 120.5, delta_min_avg: 120.5, public: true, public_id: "7488a646-e31f-11e4-aace-600308960662", week: 42, year: 42}
  @update_attrs %{addition_average: 456.7, addition_count: 43, deletion_average: 456.7, deletion_count: 43, delta_max_avg: 456.7, delta_min_avg: 456.7, public: false, public_id: "7488a646-e31f-11e4-aace-600308960668", week: 43, year: 43}
  @invalid_attrs %{addition_average: nil, addition_count: nil, deletion_average: nil, deletion_count: nil, delta_max_avg: nil, delta_min_avg: nil, public: nil, public_id: nil, week: nil, year: nil}

  def fixture(:progress_report) do
    {:ok, progress_report} = Insights.create_progress_report(@create_attrs)
    progress_report
  end

  describe "index" do
    test "lists all progress_reports", %{conn: conn} do
      conn = get(conn, Routes.progress_report_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Progress reports"
    end
  end

  describe "new progress_report" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.progress_report_path(conn, :new))
      assert html_response(conn, 200) =~ "New Progress report"
    end
  end

  describe "create progress_report" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.progress_report_path(conn, :create), progress_report: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.progress_report_path(conn, :show, id)

      conn = get(conn, Routes.progress_report_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Progress report"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.progress_report_path(conn, :create), progress_report: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Progress report"
    end
  end

  describe "edit progress_report" do
    setup [:create_progress_report]

    test "renders form for editing chosen progress_report", %{conn: conn, progress_report: progress_report} do
      conn = get(conn, Routes.progress_report_path(conn, :edit, progress_report))
      assert html_response(conn, 200) =~ "Edit Progress report"
    end
  end

  describe "update progress_report" do
    setup [:create_progress_report]

    test "redirects when data is valid", %{conn: conn, progress_report: progress_report} do
      conn = put(conn, Routes.progress_report_path(conn, :update, progress_report), progress_report: @update_attrs)
      assert redirected_to(conn) == Routes.progress_report_path(conn, :show, progress_report)

      conn = get(conn, Routes.progress_report_path(conn, :show, progress_report))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, progress_report: progress_report} do
      conn = put(conn, Routes.progress_report_path(conn, :update, progress_report), progress_report: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Progress report"
    end
  end

  describe "delete progress_report" do
    setup [:create_progress_report]

    test "deletes chosen progress_report", %{conn: conn, progress_report: progress_report} do
      conn = delete(conn, Routes.progress_report_path(conn, :delete, progress_report))
      assert redirected_to(conn) == Routes.progress_report_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.progress_report_path(conn, :show, progress_report))
      end
    end
  end

  defp create_progress_report(_) do
    progress_report = fixture(:progress_report)
    {:ok, progress_report: progress_report}
  end
end
