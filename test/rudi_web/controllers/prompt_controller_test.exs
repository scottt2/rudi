defmodule RudiWeb.PromptControllerTest do
  use RudiWeb.ConnCase

  alias Rudi.Drills

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:prompt) do
    {:ok, prompt} = Drills.create_prompt(@create_attrs)
    prompt
  end

  describe "index" do
    test "lists all prompts", %{conn: conn} do
      conn = get(conn, Routes.prompt_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Prompts"
    end
  end

  describe "new prompt" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.prompt_path(conn, :new))
      assert html_response(conn, 200) =~ "New Prompt"
    end
  end

  describe "create prompt" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.prompt_path(conn, :create), prompt: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.prompt_path(conn, :show, id)

      conn = get(conn, Routes.prompt_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Prompt"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.prompt_path(conn, :create), prompt: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Prompt"
    end
  end

  describe "edit prompt" do
    setup [:create_prompt]

    test "renders form for editing chosen prompt", %{conn: conn, prompt: prompt} do
      conn = get(conn, Routes.prompt_path(conn, :edit, prompt))
      assert html_response(conn, 200) =~ "Edit Prompt"
    end
  end

  describe "update prompt" do
    setup [:create_prompt]

    test "redirects when data is valid", %{conn: conn, prompt: prompt} do
      conn = put(conn, Routes.prompt_path(conn, :update, prompt), prompt: @update_attrs)
      assert redirected_to(conn) == Routes.prompt_path(conn, :show, prompt)

      conn = get(conn, Routes.prompt_path(conn, :show, prompt))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, prompt: prompt} do
      conn = put(conn, Routes.prompt_path(conn, :update, prompt), prompt: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Prompt"
    end
  end

  describe "delete prompt" do
    setup [:create_prompt]

    test "deletes chosen prompt", %{conn: conn, prompt: prompt} do
      conn = delete(conn, Routes.prompt_path(conn, :delete, prompt))
      assert redirected_to(conn) == Routes.prompt_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.prompt_path(conn, :show, prompt))
      end
    end
  end

  defp create_prompt(_) do
    prompt = fixture(:prompt)
    {:ok, prompt: prompt}
  end
end
