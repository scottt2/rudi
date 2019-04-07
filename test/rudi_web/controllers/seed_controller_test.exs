defmodule RudiWeb.SeedControllerTest do
  use RudiWeb.ConnCase

  alias Rudi.Drills

  @create_attrs %{body: "some body", public: true}
  @update_attrs %{body: "some updated body", public: false}
  @invalid_attrs %{body: nil, public: nil}

  def fixture(:seed) do
    {:ok, seed} = Drills.create_seed(@create_attrs)
    seed
  end

  describe "index" do
    test "lists all seeds", %{conn: conn} do
      conn = get(conn, Routes.seed_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Seeds"
    end
  end

  describe "new seed" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.seed_path(conn, :new))
      assert html_response(conn, 200) =~ "New Seed"
    end
  end

  describe "create seed" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.seed_path(conn, :create), seed: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.seed_path(conn, :show, id)

      conn = get(conn, Routes.seed_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Seed"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.seed_path(conn, :create), seed: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Seed"
    end
  end

  describe "edit seed" do
    setup [:create_seed]

    test "renders form for editing chosen seed", %{conn: conn, seed: seed} do
      conn = get(conn, Routes.seed_path(conn, :edit, seed))
      assert html_response(conn, 200) =~ "Edit Seed"
    end
  end

  describe "update seed" do
    setup [:create_seed]

    test "redirects when data is valid", %{conn: conn, seed: seed} do
      conn = put(conn, Routes.seed_path(conn, :update, seed), seed: @update_attrs)
      assert redirected_to(conn) == Routes.seed_path(conn, :show, seed)

      conn = get(conn, Routes.seed_path(conn, :show, seed))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, seed: seed} do
      conn = put(conn, Routes.seed_path(conn, :update, seed), seed: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Seed"
    end
  end

  describe "delete seed" do
    setup [:create_seed]

    test "deletes chosen seed", %{conn: conn, seed: seed} do
      conn = delete(conn, Routes.seed_path(conn, :delete, seed))
      assert redirected_to(conn) == Routes.seed_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.seed_path(conn, :show, seed))
      end
    end
  end

  defp create_seed(_) do
    seed = fixture(:seed)
    {:ok, seed: seed}
  end
end
