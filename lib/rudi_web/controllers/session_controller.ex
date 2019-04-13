defmodule RudiWeb.SessionController do
  use RudiWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case RudiWeb.Auth.login_by_email_and_pass(conn, email, pass) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Couldn't stay away, eh?")
        |> redirect(to: Routes.user_path(conn, :profile))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Hmm...wrong username or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> RudiWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end