defmodule RudiWeb.UserPromptControllerTest do
  use RudiWeb.ConnCase

  alias Rudi.Drills

  @create_attrs %{active: true, data: %{}, end_at_local_epoch: 42, end_at_utc: ~N[2010-04-17 14:00:00], interupted: true, result: "some result", start_at_local_epoch: 42, start_at_utc: ~N[2010-04-17 14:00:00]}
  @update_attrs %{active: false, data: %{}, end_at_local_epoch: 43, end_at_utc: ~N[2011-05-18 15:01:01], interupted: false, result: "some updated result", start_at_local_epoch: 43, start_at_utc: ~N[2011-05-18 15:01:01]}
  @invalid_attrs %{active: nil, data: nil, end_at_local_epoch: nil, end_at_utc: nil, interupted: nil, result: nil, start_at_local_epoch: nil, start_at_utc: nil}

  def fixture(:user_prompt) do
    {:ok, user_prompt} = Drills.create_user_prompt(@create_attrs)
    user_prompt
  end

  describe "index" do
    test "lists all user_prompts", %{conn: conn} do
      conn = get(conn, Routes.user_prompt_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing User prompts"
    end
  end

  describe "new user_prompt" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_prompt_path(conn, :new))
      assert html_response(conn, 200) =~ "New User prompt"
    end
  end

  describe "create user_prompt" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_prompt_path(conn, :create), user_prompt: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_prompt_path(conn, :show, id)

      conn = get(conn, Routes.user_prompt_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User prompt"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_prompt_path(conn, :create), user_prompt: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User prompt"
    end
  end

  describe "edit user_prompt" do
    setup [:create_user_prompt]

    test "renders form for editing chosen user_prompt", %{conn: conn, user_prompt: user_prompt} do
      conn = get(conn, Routes.user_prompt_path(conn, :edit, user_prompt))
      assert html_response(conn, 200) =~ "Edit User prompt"
    end
  end

  describe "update user_prompt" do
    setup [:create_user_prompt]

    test "redirects when data is valid", %{conn: conn, user_prompt: user_prompt} do
      conn = put(conn, Routes.user_prompt_path(conn, :update, user_prompt), user_prompt: @update_attrs)
      assert redirected_to(conn) == Routes.user_prompt_path(conn, :show, user_prompt)

      conn = get(conn, Routes.user_prompt_path(conn, :show, user_prompt))
      assert html_response(conn, 200) =~ "some updated result"
    end

    test "renders errors when data is invalid", %{conn: conn, user_prompt: user_prompt} do
      conn = put(conn, Routes.user_prompt_path(conn, :update, user_prompt), user_prompt: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User prompt"
    end
  end

  describe "delete user_prompt" do
    setup [:create_user_prompt]

    test "deletes chosen user_prompt", %{conn: conn, user_prompt: user_prompt} do
      conn = delete(conn, Routes.user_prompt_path(conn, :delete, user_prompt))
      assert redirected_to(conn) == Routes.user_prompt_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.user_prompt_path(conn, :show, user_prompt))
      end
    end
  end

  defp create_user_prompt(_) do
    user_prompt = fixture(:user_prompt)
    {:ok, user_prompt: user_prompt}
  end
end
