defmodule RudiWeb.UserPromptChannel do
  use RudiWeb, :channel

  def join("user_prompt:" <> user_prompt_id, _params, socket) do
    [username, prompt_id] = String.split(user_prompt_id, ":")
    # TODO: Make sure this is all up to snuff
    up = case Rudi.Responses.get_active_user_prompt(:with_ids, socket.assigns.user_id, prompt_id) do
      # NOTE: If there exists a persisted UserPrompt, mark it as interupted if active
      nil -> nil
      existing_up ->
        cond do
          existing_up.active == true ->
            case Rudi.Repo.update(existing_up |> Ecto.Changeset.change(interupt_count: existing_up.interupt_count + 1)) do
              {:ok, updated_up} -> updated_up
              {:error, _} -> existing_up
            end
          true -> existing_up
        end
      _ -> nil
    end

    socket =
      socket
      |> assign(:prompt_id, prompt_id)
      |> assign(:socket_id, user_prompt_id)
      |> assign(:user_prompt, up)

    {:ok, socket}
  end

  def handle_in("start", %{ "epoch" => start_at_device_epoch }, socket) do
    up = case socket.assigns.user_prompt do
      nil ->
        prompt = Rudi.Drills.get_prompt_by_public_id!(socket.assigns.prompt_id)
        Rudi.Repo.insert!(%Rudi.Responses.UserPrompt{
          user_id: socket.assigns.user_id,
          prompt_id: prompt.id,
          socket_id: socket.assigns.socket_id
        })
      _ -> socket.assigns.user_prompt
    end
    socket = case up.start_at_device_epoch do
      nil ->
        updated_up =
          up
          |> Ecto.Changeset.change(
            active: true,
            start_at_device_epoch: start_at_device_epoch,
            start_at_utc: DateTime.utc_now |> DateTime.truncate(:second)
          )
        case Rudi.Repo.update(updated_up) do
          {:ok, updated_up} -> socket |> assign(:user_prompt, updated_up)
          {:error, _} -> socket
        end
      _ -> socket
    end
    {:noreply, socket}
  end

  def handle_in("stop", %{ "body" => body, "epoch" => end_at_device_epoch }, socket) do
    socket = case socket.assigns.user_prompt.end_at_device_epoch do
      nil ->
        updated_up =
          socket.assigns.user_prompt
          |> Ecto.Changeset.change(
            active: false,
            body: body,
            end_at_device_epoch: end_at_device_epoch,
            end_at_utc: DateTime.utc_now |> DateTime.truncate(:second)
          )
        case Rudi.Repo.update(updated_up) do
          {:ok, updated_up} ->
            Task.Supervisor.async_nolink(Rudi.TaskSupervisor, fn ->
              Rudi.Tasks.ProcessRep.run(updated_up)
            end)
            socket |> assign(:user_prompt, updated_up)
          {:error, _} -> socket
        end
      _ -> socket
    end
    {:noreply, socket}
  end

  def handle_in("typed", %{
    "action" => action,
    "body" => body,
    "ts" => ts,
    "value" => value
  }, socket) do
    updated_typings = [ts, action, value] ++ (socket.assigns.user_prompt.typings || [])
    socket =
      case Rudi.Repo.update(socket.assigns.user_prompt |> Ecto.Changeset.change(body: body, typings: updated_typings)) do
        {:ok, updated_up} -> socket |> assign(:user_prompt, updated_up)
        {:error, _} -> socket
      end
    {:noreply, socket}
  end
end
