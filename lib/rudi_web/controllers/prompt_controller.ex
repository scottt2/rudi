defmodule RudiWeb.PromptController do
  use RudiWeb, :controller

  alias Rudi.Drills
  alias Rudi.Drills.Prompt

  def index(conn, _params) do
    prompts = Drills.list_prompts()
    render(conn, "index.html", prompts: prompts)
  end

  def new(conn, _params) do
    changeset = Drills.change_prompt(%Prompt{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"prompt" => prompt_params}) do
    case Drills.create_prompt(prompt_params) do
      {:ok, prompt} ->
        conn
        |> put_flash(:info, "Prompt created successfully.")
        |> redirect(to: Routes.prompt_path(conn, :show, prompt))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    prompt = Drills.get_prompt_by_public_id!(id)
    render(conn, "show.html", prompt: prompt)
  end

  def edit(conn, %{"id" => id}) do
    prompt = Drills.get_prompt!(id)
    changeset = Drills.change_prompt(prompt)
    render(conn, "edit.html", prompt: prompt, changeset: changeset)
  end

  def update(conn, %{"id" => id, "prompt" => prompt_params}) do
    prompt = Drills.get_prompt!(id)

    case Drills.update_prompt(prompt, prompt_params) do
      {:ok, prompt} ->
        conn
        |> put_flash(:info, "Prompt updated successfully.")
        |> redirect(to: Routes.prompt_path(conn, :show, prompt))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", prompt: prompt, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    prompt = Drills.get_prompt!(id)
    {:ok, _prompt} = Drills.delete_prompt(prompt)

    conn
    |> put_flash(:info, "Prompt deleted successfully.")
    |> redirect(to: Routes.prompt_path(conn, :index))
  end
end
