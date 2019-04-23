defmodule RudiWeb.PromptController do
  use RudiWeb, :controller

  alias Rudi.Drills
  alias Rudi.Drills.Prompt
  alias Rudi.Responses

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
    prompt = cond do
      id == "today" ->
        now_date = Date.utc_today()
        case Drills.get_prompt_for_date!(:include_associations, now_date) do
          nil ->
            Rudi.Repo.insert!(%Rudi.Drills.Prompt{
              of_the_day: now_date,
              seed: Rudi.Drills.get_random_seed!,
              skill: Rudi.Drills.get_random_skill!,
            })
          prompt -> prompt
        end
      true -> Drills.get_prompt_by_public_id!(id)
    end
    # TODO: Consolidate
    user_prompts = Responses.list_completed_user_prompts(conn.assigns.current_user, prompt)
    active_user_prompt = Responses.get_active_user_prompt(conn.assigns.current_user, prompt) |> Jason.encode!
    render(conn, "show.html", active_user_prompt: active_user_prompt, prompt: prompt, user_prompts: user_prompts)
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
