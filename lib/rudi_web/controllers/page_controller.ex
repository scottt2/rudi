defmodule RudiWeb.PageController do
  use RudiWeb, :controller

  def coach(conn, _params) do
    render(conn, "coach.html")
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
