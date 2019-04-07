defmodule Rudi.Repo do
  use Ecto.Repo,
    otp_app: :rudi,
    adapter: Ecto.Adapters.Postgres
end
