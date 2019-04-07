defmodule RudiWeb.UserPromptChannel do
  use RudiWeb, :channel

  def join("user_prompt:" <> user_prompt_id, _params, socket) do
    { :ok, assign(socket, :user_prompt_id, user_prompt_id) }
  end
end