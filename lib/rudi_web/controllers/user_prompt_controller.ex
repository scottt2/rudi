defmodule RudiWeb.UserPromptController do
  use RudiWeb, :controller

  alias Rudi.Responses
  alias Rudi.Responses.UserPrompt

  def index(conn, _params) do
    user_prompts = Responses.list_user_prompts()
    render(conn, "index.html", user_prompts: user_prompts)
  end

  def new(conn, _params) do
    changeset = Responses.change_user_prompt(%UserPrompt{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_prompt" => user_prompt_params}) do
    case Responses.create_user_prompt(user_prompt_params) do
      {:ok, user_prompt} ->
        conn
        |> put_flash(:info, "User prompt created successfully.")
        |> redirect(to: Routes.user_prompt_path(conn, :show, user_prompt))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_prompt = Responses.get_user_prompt!(id)
    render(conn, "show.html", user_prompt: user_prompt)
  end

  def edit(conn, %{"id" => id}) do
    user_prompt = Responses.get_user_prompt!(id)
    changeset = Responses.change_user_prompt(user_prompt)
    render(conn, "edit.html", user_prompt: user_prompt, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_prompt" => user_prompt_params}) do
    user_prompt = Responses.get_user_prompt!(id)

    case Responses.update_user_prompt(user_prompt, user_prompt_params) do
      {:ok, user_prompt} ->
        conn
        |> put_flash(:info, "User prompt updated successfully.")
        |> redirect(to: Routes.user_prompt_path(conn, :show, user_prompt))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_prompt: user_prompt, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_prompt = Responses.get_user_prompt!(id)
    {:ok, _user_prompt} = Responses.delete_user_prompt(user_prompt)

    conn
    |> put_flash(:info, "User prompt deleted successfully.")
    |> redirect(to: Routes.user_prompt_path(conn, :index))
  end
end
