defmodule RudiWeb.SeedController do
  use RudiWeb, :controller

  alias Rudi.Drills
  alias Rudi.Drills.Seed

  def index(conn, _params) do
    seeds = Drills.list_seeds()
    render(conn, "index.html", seeds: seeds)
  end

  def new(conn, _params) do
    changeset = Drills.change_seed(%Seed{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"seed" => seed_params}) do
    case Drills.create_seed(conn.assigns.current_user, seed_params) do
      {:ok, seed} ->
        conn
        |> put_flash(:info, "Seed created successfully.")
        |> redirect(to: Routes.seed_path(conn, :show, seed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    seed = Drills.get_seed_by_public_id!(id)
    render(conn, "show.html", seed: seed)
  end

  def edit(conn, %{"id" => id}) do
    seed = Drills.get_seed!(id)
    changeset = Drills.change_seed(seed)
    render(conn, "edit.html", seed: seed, changeset: changeset)
  end

  def update(conn, %{"id" => id, "seed" => seed_params}) do
    seed = Drills.get_seed!(id)

    case Drills.update_seed(seed, seed_params) do
      {:ok, seed} ->
        conn
        |> put_flash(:info, "Seed updated successfully.")
        |> redirect(to: Routes.seed_path(conn, :show, seed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", seed: seed, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    seed = Drills.get_seed!(id)
    {:ok, _seed} = Drills.delete_seed(seed)

    conn
    |> put_flash(:info, "Seed deleted successfully.")
    |> redirect(to: Routes.seed_path(conn, :index))
  end
end
