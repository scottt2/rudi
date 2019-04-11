defmodule Rudi.Workers.PromptOfTheDay do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_state) do
    Process.send_after(self(), {:run, Timex.now()}, 1000)
    {:ok, nil}
  end

  def handle_info({:run, now}, _state) do
    now_date = now |> Timex.to_date()
    Logger.info "[PromptOfTheDay] Processing #{now_date}..."
    case Rudi.Drills.get_prompt_for_date!(now_date) do
      nil ->
        Rudi.Repo.insert!(%Rudi.Drills.Prompt{
          of_the_day: now_date,
          seed: Rudi.Drills.get_random_seed!,
          skill: Rudi.Drills.get_random_skill!,
        })
        Logger.info "[PromptOfTheDay] Created prompt"
      _ -> Logger.info "[PromptOfTheDay] Prompt already exists"
    end

    tomorrow = Timex.add(now, Timex.Duration.from_days(1))
    tomorrow_epoch = (tomorrow |> Timex.to_unix()) * 1000
    now_epoch = DateTime.utc_now() |> DateTime.to_unix(:millisecond)
    run_after = (tomorrow_epoch + 1000) - now_epoch

    Process.send_after(self(), {:run, tomorrow |> Timex.to_date()}, run_after)
    {:noreply, nil}
  end
end