defmodule RudiWeb.PageController do
  use RudiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
