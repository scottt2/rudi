defmodule RudiWeb.ProgressReportController do
  use RudiWeb, :controller

  alias Rudi.Insights
  alias Rudi.Insights.ProgressReport

  def index(conn, _params) do
    progress_reports = Insights.list_progress_reports()
    render(conn, "index.html", progress_reports: progress_reports)
  end

  def show(conn, %{"id" => week}) do
    progress_report = Insights.get_progress_report!(:week, week, conn.assigns.current_user.id)
    render(conn, "show.html", progress_report: progress_report)
  end
end
